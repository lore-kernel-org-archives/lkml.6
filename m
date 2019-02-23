Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E994C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C5D206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfBWTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 14:47:38 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:55094 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfBWTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 14:47:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id C6B744A50;
        Sat, 23 Feb 2019 20:37:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PVdfEGz0q_eO; Sat, 23 Feb 2019 20:37:50 +0100 (CET)
Received: from function (dhcp-97-171.dsi-ext.ens-lyon.fr [140.77.97.171])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BF7DF46B3;
        Sat, 23 Feb 2019 20:37:50 +0100 (CET)
Received: from samy by function with local (Exim 4.92-RC6)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gxd7O-0004Rp-2u; Sat, 23 Feb 2019 20:37:50 +0100
Date:   Sat, 23 Feb 2019 20:37:50 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: Replace simple_strtoul with kstrtoul
Message-ID: <20190223193750.2yd3qiyr6q3wx463@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Bharath Vedartham <linux.bhar@gmail.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190223193121.GA4402@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223193121.GA4402@bharath12345-Inspiron-5559>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Vedartham, le dim. 24 févr. 2019 01:01:21 +0530, a ecrit:
> simple_strtoul is obsolete. Change it to kstrtoul. Kernel is building
> and booting successfully.

Please recheck your patch, temp is used after the simple_strtoul call.

Samuel
