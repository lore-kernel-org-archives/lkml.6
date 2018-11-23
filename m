Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7368CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D31B20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D31B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503262AbeKWVO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:14:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393942AbeKWVO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:14:57 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQ8jw-000413-Ng; Fri, 23 Nov 2018 11:31:13 +0100
Date:   Fri, 23 Nov 2018 11:31:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Manfred Rudigier <manfred.rudigier@omicronenergy.com>
cc:     Richard Cochran <richardcochran@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cristian Marinescu <cristian.marinescu@omicronenergy.com>
Subject: RE: [patch 8/9] posix-clocks: Remove license boiler plate
In-Reply-To: <559fb263-6c05-4ee7-8789-27c123ba8b9d@EXC03-ATKLA.omicron.at>
Message-ID: <alpine.DEB.2.21.1811231130320.2603@nanos.tec.linutronix.de>
References: <20181031182107.726051323@linutronix.de> <20181031182253.385909804@linutronix.de> <20181101021203.6twk2pucmn42cu6z@localhost> <559fb263-6c05-4ee7-8789-27c123ba8b9d@EXC03-ATKLA.omicron.at>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Manfred Rudigier wrote:

> Acked-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>

Thanks Manfred! Very appreciated!

       Thomas
