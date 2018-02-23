Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x224Dyv8WcmedJ+VKpmxsoKS3eVn4GIyhz6xXUaxUTs2pcSDpXNikKuZ8XRcbV9Sx9zMspaBM
ARC-Seal: i=1; a=rsa-sha256; t=1519399065; cv=none;
        d=google.com; s=arc-20160816;
        b=ODoLmSMUSDUg5XD3lQhfFH4r545uK8iGaG4w0rwwPw2DVJWpks+1CzkHDrEMLHqdDj
         LRPiCOgmR4hBdzf6D48k1RiQol96NmI0uw5QZfHBWhvqZb9Z4RV7Z/JnoeG1L7qmWr5N
         yVrJvsf3GKrYnG0zt9hnbqeoEj9SpEOdV0QmFq29VkFjPpF6ObzJ2akEr2Ext5i+qidN
         SsxhYy3YycmZ2uwZfJDGFQYNOT2EzWn2WijtTloLS+ool4rnbHoTxO8LfxC4mno8gp9k
         PAuL2W1uFC8Sia8wnWnShS0eBpfmwCxPalh9hIHVGhaGRNNKyAoKXlhbBtzIy/x+Gp3z
         eP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=8SsnQnLJ6CtlfBUO+IyaGSaHdI4SaOPgqr/QdiQm3XU=;
        b=BvqkcoG19y9kJeqUYvXV2hFcl08cJ5/3RKbzUPf9F1WNlu6K4zvkCfd0ZEm4LEPUDl
         T8IFEdxJ7rsk4BIkS7CBp7QmLaWpHhi+06NK00jF2R/XgIv9C4ZPCB7xi3bnzluXAGQL
         Dzkpfn6d9dCh9APk9WUGNt8bfC4BipDLvQPqDoqZTVho4et+7fGWgkRD0vcpRMV5EoVq
         YCiLjVSURKRadvDARhx3g1Suu8HyH2h9HLVrYgGD+Ld1w4HBHL+LqLlaGHKCMDRtHx1n
         JrWH0bDSnwUAa9TkaCPfFzcaZKdDNrBbj2wLjyyRapHerISF3UhzpsR4M8LUssEq6QyC
         w9PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Feb 2018 08:17:43 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, linux-kernel@vger.kernel.org, Greg
 KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3] aoe: document sysfs interface
Message-ID: <20180223081743.5c111bc5@lwn.net>
In-Reply-To: <20180219181653.GA2925@mordor.localdomain>
References: <20180219181653.GA2925@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592854282679037569?=
X-GMAIL-MSGID: =?utf-8?q?1593205394154428265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Feb 2018 23:46:53 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Documentation has been compiled from git commit logs and descriptions in
> Documentation/aoe/aoe.txt. This should be useful for scripting and
> tracking changes in the ABI.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to the docs tree, thanks.

jon
