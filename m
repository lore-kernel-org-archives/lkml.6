Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3E821738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfBTApn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:45:43 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:35910 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfBTApn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:45:43 -0500
Received: by mail-pl1-f178.google.com with SMTP id k2so1922512plt.3;
        Tue, 19 Feb 2019 16:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4jxKbExNFqvLEeW1vDv3tEjsXR+M3HCl5iBM4sqV9Q=;
        b=B9cpg+46cp7IcJ5pWIVecpws7fFz411O3NqUTimbt4g3HmxZcYx0r43PrZLCQbG3AA
         q05tXBQWtprDwsNiDOwNBO85Ym6MWkp12zZ9+Jr3J1pdfxDxmOOilGTIqlzokj5aO0GB
         IsSbPwoNgBkVxaJbVM1q1uDPDDRz06OdrUc61NmNKAUBFhuYvHbj9+V5pUnQYlNWOW0h
         AYFEKU37nkHmZGTqHgj4rfDiOcYF3x+ZckktxZ1PCcdE+czLxBaVhWl5V5/z489xa6uL
         UERVyOULRgQ3NNJR5W4/5w2URZKsCqZrTXUmDb1CUZ2FJZtcrp8VNAMMCw69E3HFdcYM
         oCNQ==
X-Gm-Message-State: AHQUAuYW/NsVhZwahmHFWuLg6GqUedW89uCZS3CBqKRbntS6N4RshhJt
        phBIoJ9CgiHGkxsBiV1Sw9k=
X-Google-Smtp-Source: AHgI3Iax4GJqOB77v6suzLS2amXEw2p4rhZ8C5XNF1hgcp5248OmNCu2obXGfwUuRh4mX45C7wpAFA==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr12084687pln.151.1550623542615;
        Tue, 19 Feb 2019 16:45:42 -0800 (PST)
Received: from ?IPv6:2620:15c:2d1:206:bfe1:be9c:5072:1789? ([2620:15c:2d1:206:bfe1:be9c:5072:1789])
        by smtp.gmail.com with ESMTPSA id b4sm18893963pgq.57.2019.02.19.16.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 16:45:41 -0800 (PST)
Message-ID: <1550623540.93548.6.camel@acm.org>
Subject: Re: [PATCH] scsi: clean obsolete return values of eh_timed_out
From:   Bart Van Assche <bvanassche@acm.org>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Date:   Tue, 19 Feb 2019 16:45:40 -0800
In-Reply-To: <1550385027-6217-1-git-send-email-avri.altman@wdc.com>
References: <1550385027-6217-1-git-send-email-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-02-17 at 08:30 +-0200, Avri Altman wrote:
+AD4 Those are no longer in use since commit 242f9dcb8ba6
+AD4 (+ACI-block: unify request timeout handling+ACI).

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


