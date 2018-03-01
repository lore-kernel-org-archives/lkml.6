Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AG47ELubAAeSjQALxiDuwLO4vDwy4g8PIM/zkF3QAHScyzxFp9Ds+MuzGyTPcxRnRkf/dReeapMB
ARC-Seal: i=1; a=rsa-sha256; t=1519886098; cv=none;
        d=google.com; s=arc-20160816;
        b=TqEx7xyYhnvzlWTmxc5UA5vq2qdeUJb2GsFg07KHjsJ3phuRJfI32Ot5/Ye/2MVaA6
         4P4mgXtY0x8lpTBz8r25H90oEKBKIJIbSE+J64WCEnwnqcIv4LBex4wC20eUzH8wKmUC
         KQXIlSq5d6CSsrpwAWGjFkvLDzXHzcNQ0h75kdJbrYe5fcjcMobC4E8+3/sWJxdycIJ9
         PPwZjc1RLt/1QTMGbLH4tmMCIs2qhS9jNIU/7C8ZBxSBaEfB95jMt7EpISZgvoTi4kTx
         o2kQvS0utan5dOn0RwTvUH19nClF7xD7XhcMexfhv7xg4ld+C3EsHpAR7zU2sGundG8t
         6UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=jOreFu/c97a4fEXPN5m088EWikHrbVZNTa8lx3MHRfQ=;
        b=k0ee55g/VmTkxKOMObbl5q9qtaLg+NZRJJ0vm/n3BrjenGAgog5pEhP5D+LTJEHZJD
         tFIhfznKyUFFoQmEzVPs8THlVlLHTfxvPJRl9pmcrMwkibHYSWUQDIazj/EsNfAHGe82
         HieJy4leULLvLjbWDDxETE3z3k1//1TGtUXdOm5Cee2N9Su4Fcn1fbUYcjx7H6kzFbYN
         MqH8iN4cauNaI6fLoxSX48ulT/zglAGPCEQqtNJoBAkNErwF/+GNF6vmLmsHvRuRmcnk
         wrD+wvF/XSI5BzkfWtXVhvk2BnAA1i935wPTOThrBOSaTNz8zgwWdPCtrvkthPVul0wM
         JgDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=RkQpuiOh;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=kaH94eEI;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=RkQpuiOh;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=kaH94eEI;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:EZ-XWg2D9vRIoHo_pNGV_tI16cVw3jH0U_amWEcWsoMdQGsax5E8Xw>
Date: Thu, 1 Mar 2018 17:34:54 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: gregkh@linuxfoundation.org, wsa@the-dreams.de,
	devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: ks7010: Use constants from ieee80211_eid
 instead of literal ints.
Message-ID: <20180301063454.GC4059@eros>
References: <20180301051911.1314-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301051911.1314-1-quytelda@tamalin.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593711342664103633?=
X-GMAIL-MSGID: =?utf-8?q?1593716085511149558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 09:19:07PM -0800, Quytelda Kahja wrote:
...

I would normally respond to the cover letter but here goes.

Reviewed-by: Tobin C. Harding <me@tobin.cc>

thanks,
Tobin.
