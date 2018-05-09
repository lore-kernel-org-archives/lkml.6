Return-Path: <jmorris@namei.org>
X-Google-Smtp-Source: AB8JxZolwqxz7CXmJWJspd8m/ASdeJiVAv8KbjH05Rws7EZdlwNdsLMdWQnM+s+25WHEW2i28LL3
ARC-Seal: i=1; a=rsa-sha256; t=1525893419; cv=none;
        d=google.com; s=arc-20160816;
        b=CVkZgKM/TrlqumyEObClSRro1GkM4G5rNwJ39wu3Pce/1+AUFkzIxCtgCfrIR3ebKQ
         Iz7sIgnko6eP+TgHB7KQ9+p7KRhE8r+X5fOiq+4AxHjSq/QrHZ4eyoxiZiTVHFXITVS/
         z8BT0OcO7BuLPFbKjhNIjRXVmlFPcFviHF2YTnlinEy0dP9a1PubA7IDgDay0oDAn0ve
         c13gQUpg8Br4vfUQDd1EmArywHElQTYfMvY8LD725FK8esx7SsorrBwEfnE751km4Wtp
         htdRCAkbMro0fhvsZwJctn8DFCCXqCxeebr9Xgg4KI6Xeq3ciZU1ZjH9vNXTpT3267uK
         9Eqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=XB7Xw9RvXG/eENKYqyrfKON9sOURAbG5DIEXsqCKyfc=;
        b=Wi3BJGjx1wdBoOd4Fg6QtErY60sC71xj1nrsrZk2qsr59UDBSMspr2JRxf1AasQ+Kg
         TmpRgzSkUxE8h5IelCDuCffSyXUuHJNkoGbo+isx//m/DmxR4zAifXOZMAwN6RtscxoV
         rqRjM/mYCnwUlNa/wXbsvlkmN9CLqGQ0uRuDpgZnaGPbf/pxsU5+HaauUI1Dv/R/VA4N
         5wUmnKdSrUHpKqGBvRH/UHdNJ/J77d23AUiLGLfsJZXquf7UnnaYWymTrT8V/40DsG9J
         +Peptxit977zGXgoYNC91TcEqNty3kpMjwt83anf0DzvyOBlMuwYy7ZmYzBvRaZlgUR4
         D8PA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Date: Thu, 10 May 2018 05:16:43 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
cc: peterhuewe@gmx.de, tweek@google.com, jarkko.sakkinen@linux.intel.com,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        javierm@redhat.com, sonnyrao@chromium.org,
        enric.balletbo@collabora.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: replace kmalloc() + memcpy() with kmemdup()
In-Reply-To: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
Message-ID: <alpine.LRH.2.21.1805100516350.12749@namei.org>
References: <CGME20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f@epcas1p4.samsung.com> <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599943245926622446?=
X-GMAIL-MSGID: =?utf-8?q?1600015217912548529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 9 May 2018, Ji-Hun Kim wrote:

> Use kmemdup rather than duplicating its implementation.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
