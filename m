Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521042616; cv=none;
        d=google.com; s=arc-20160816;
        b=UljS9nk1Bj47qZfazRxNQg/3CHM5bj4cIuK58DMm2BTBDWfxzvGTkbNeTfZnaHWtAH
         zGCttWGvd+BQrNJwGJ6a4+h+LHYrgv7IJhYNCeI3QhxeQdex8bHw1cvLqN38/Ezq6D2x
         LntEq+D0OOkWOzY/jEtaBxEzCMz8bwMxu0vArEO+WJuhwDN1AS+wyB7+v/nsdsvLWDXx
         /WKSUtHylPK5wih0WeuSvqoVyedVutD2XQkAPqSHFULJ94yVVBj0ABm2Ztrb6R2D41se
         Sk59LMf+WqqaZafseqfsFlSr8EmBNysPQrty39V5luyXfORL7vdmLbdNXlHIPxdzNUcH
         uu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=IkgnelfHEM7ytKFm1/ZRElzId/46F9MXfL6QXtVNYtU=;
        b=BvC9BOMbv3nwIA7maNhGrsyWBSocMP4YRgMTZQq/MeB4l1kDXYSaX78X1s+qvA7Uw/
         AX0oWtx29KZCJ4nIc5IjjxRZR1tJo1WrsGBVGKzG3WWPQvZsIr2myzAzCaumyBHOmPB2
         WuF4tQmPWOstBCCN8O7b/DsODwHPxUd+zqf8ykZCeGVtTWDVa0f9dlMvkpYRAas3kpbW
         v8qIET4ByqrNnEewUl6A+rnSW3XD+1iAdcZYEVE+DFYfiXGuBsC7CjYtBIEZoJtoWtkZ
         S8Hu4tGZur4VJb3QZ81fU5qMj62PsaIaWaBUcaDSHqLesCM3ET9QZm3lM8j98GMbsjyM
         u+hA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JNcoLM08;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JNcoLM08;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELvPjDlTdAHGO2P5I2d1UoUOgxjw/pRiN8jpc5P1qqENfI1tsbBMsuhQZLsVpKjGhKco/9+Ccg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 14 Mar 2018 08:50:14 -0700
From: Tejun Heo <tj@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 26/47] ata: remove bf54x driver
Message-ID: <20180314155014.GB2943022@devbig577.frc2.facebook.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-27-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-27-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928559830025521?=
X-GMAIL-MSGID: =?utf-8?q?1594928782828691901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:39PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this driver
> is obsolete as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route with the rest of the series.

Thanks.

-- 
tejun
