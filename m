Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AH8x226u3xk0aclA1w1HFzPlOF+Py3pfJ71qN9qGFOKDYmQjy1In5+n3WUMXxt6RjtKe/IyiD4t1
ARC-Seal: i=1; a=rsa-sha256; t=1517937306; cv=none;
        d=google.com; s=arc-20160816;
        b=Xbauwaf7fWvlI3ykcvN5voHzqtfvvtSy5jzOlDaY4/ah+PRWdc2ZeE/Zmwc+YBxLsq
         TW2l8py8DKoiBrikn5550NvTsrSN77+ftJs2X1x8FGl1Xc+1GgCb+p4ZhazGUnZhTRsd
         8AdwEGcr/Wn/sSc1YfNMFsG4Mb9Nw3hN/z8sgOnNjQ3rSSsMb+Livrz2fRw2dCdHoGiY
         oBHMDt+LfFxTohW/D/vF8HGj97jaW9T8kOtZEXLvl8cTlARfRfiOVanORFejnAITdbpJ
         LjXbQPtVAe1ViSdJxztfEwTchWRembTxwLN44WLNAGkUG4E1MD4/qlEgIr1ZWI51j70A
         E3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=475NEhw4HSj0Mf3Aq+zOE2yNw+l3S+VR03gLcDl0Tbg=;
        b=cT+DBHopLbxwNzPokRz8kgogRraoAlt3JL4V9Axq9Z3/wySkPx1GQH1iB6BXgWQgwj
         3cYFPqk/HOJ1qNBp0wKXjnIf7pLp+v8p6aLLahIr1I+LJ1wFN+bqC1b9kDbKqhKtETCD
         RPwug4nJvLClTOV03M6/9tHM5Zh9qjWFA9EnIhg/rsdiRBAUmJIXqOR0LghmkYI0WrvC
         16jMhf00EfiEGY7vosb0nicOK6oLHqJ6kjTpfmrkYsbunuvxYNWVsa5JEOnjBtteecuM
         fJWT8HagxmaSOmapZIl3LWGX+Z9kJMrKiHCf/Hf/blNO1zJeyocHKRdl+AM16e16XYge
         wpEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <de9e2460-3633-ee4b-904d-6510f9045b8b@deltatee.com>
Date: Tue, 6 Feb 2018 10:14:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, bfields@fieldses.org, jlayton@poochiereds.net, axboe@kernel.dk, gregkh@linuxfoundation.org, srivatsa@csail.mit.edu
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] char_dev: Fix off-by-one bugs in find_dynamic_major()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591616647486250157?=
X-GMAIL-MSGID: =?utf-8?q?1591672629034663478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks!

On 05/02/18 07:25 PM, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
> 
> CHRDEV_MAJOR_DYN_END and CHRDEV_MAJOR_DYN_EXT_END are valid major
> numbers. So fix the loop iteration to include them in the search for
> free major numbers.
> 
> While at it, also remove a redundant if condition ("cd->major != i"),
> as it will never be true.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


Logan
