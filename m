Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC857C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EE82087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbfA3RyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:54:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44927 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfA3RyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:54:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so143790plt.11;
        Wed, 30 Jan 2019 09:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iz21cN8GoT3MvN5a1uiLBVh50wHgA14ydJ//XJ4azxE=;
        b=WD2A1+giOMMa28wMzlQ3btuaLGublJdFj7AbWQHrwgLsemZfaEntkGVg2eIlWRs1Hv
         8KDz2OYt1lT8Ff5nFgNe4ankgO7MJ9Wg9uiSG78v5L7yupamJeDzOiwVVyxMoo3y12Vk
         bMpqjpGaNqK4dk0yRs18cc63NRxkf5lRbDf0Erc77aVJZKN8+GAVB0FGmDYeQAJmrDiK
         aBrTxO0glVEp0FK33+I7rNKx1IGb2r3bA8a//VPJmvr+nx34Ud8xh6m7b5pxhFx+zXQk
         5lrB46nTVCU3WhZuoQRvoT+b9XR35pYEGBk69y1RKGFg+S5WnhV/hzIfGQKvFNaig0o6
         ZTjA==
X-Gm-Message-State: AJcUukcLF8zZ0EjB2ru2KPpOLq/hFQgXhUKtFAuZuq3H1iF4M3Ptq9II
        wIie7AznJRDUBOKahVHm0TQ=
X-Google-Smtp-Source: ALg8bN4iC3UMJvRRfN5Q3GirKofTu09NnEEUBinpzuCn308iUuGjo80/sjTKHl3eqToyPEqBxE/Lng==
X-Received: by 2002:a17:902:780c:: with SMTP id p12mr30643991pll.197.1548870850795;
        Wed, 30 Jan 2019 09:54:10 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c23sm2911888pfi.83.2019.01.30.09.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 09:54:10 -0800 (PST)
Message-ID: <1548870848.213038.3.camel@acm.org>
Subject: Re: [PATCH for-next] scsi: ufs: Update dwc driver maintainer to
 Pedro Sousa
From:   Bart Van Assche <bvanassche@acm.org>
To:     Joao Pinto <joao.pinto@synopsys.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pedrom.sousa@synopsys.com, marc.w.gonzalez@free.fr,
        Alex.Lemberg@wdc.com
Date:   Wed, 30 Jan 2019 09:54:08 -0800
In-Reply-To: <812e9e1426555808ad1bd5fbfda320c6684abc81.1548869844.git.jpinto@synopsys.com>
References: <812e9e1426555808ad1bd5fbfda320c6684abc81.1548869844.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 18:48 +-0100, Joao Pinto wrote:
+AD4 Currently I am managing the Synopsys drivers +ACY tools team (full-time) and
+AD4 so I am passing the DWC UFS driver maintenance to Pedro Sousa.
+AD4 
+AD4 Signed-off-by: Joao Pinto +ADw-jpinto+AEA-synopsys.com+AD4
+AD4 Cc: Pedro Sousa +ADw-pedrom.sousa+AEA-synopsys.com+AD4
+AD4 Cc: Marc Gonzalez +ADw-marc.w.gonzalez+AEA-free.fr+AD4
+AD4 Cc: Alex Lemberg +ADw-Alex.Lemberg+AEA-wdc.com+AD4
+AD4 ---
+AD4  MAINTAINERS +AHw 2 +--
+AD4  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/MAINTAINERS b/MAINTAINERS
+AD4 index 70c93b1..458a2a2 100644
+AD4 --- a/MAINTAINERS
+AD4 +-+-+- b/MAINTAINERS
+AD4 +AEAAQA -15673,7 +-15673,7 +AEAAQA F:	Documentation/scsi/ufs.txt
+AD4  F:	drivers/scsi/ufs/
+AD4  
+AD4  UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER DWC HOOKS
+AD4 -M:	Joao Pinto +ADw-jpinto+AEA-synopsys.com+AD4
+AD4 +-M:	Pedro Sousa +ADw-pedrom.sousa+AEA-synopsys.com+AD4
+AD4  L:	linux-scsi+AEA-vger.kernel.org
+AD4  S:	Supported
+AD4  F:	drivers/scsi/ufs/+ACo-dwc+ACo

Shouldn't people have proven to be willing to stick around before being
added as a kernel maintainer? Additionally, what is the experience level of
Pedro with kernel development? All I know is the following:

+ACQ git log --author +ACI-Pedro Sousa+ACI +AHw wc -l
0
+ACQ git log +AHw grep -c +ACI-Pedro Sousa+ACI
0

Are you aware that people who are not mentioned in the MAINTAINERS file are
allowed to review kernel patches?

Thanks,

Bart.


