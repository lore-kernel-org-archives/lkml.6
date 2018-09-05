Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE619C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BDB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BDB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIEMuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:50:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:52602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeIEMuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:50:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AC2FAEA5;
        Wed,  5 Sep 2018 08:20:56 +0000 (UTC)
Date:   Wed, 5 Sep 2018 10:20:55 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Subject: Re: [PATCH v2 0/2] Rumble support for Xbox One S controller
In-Reply-To: <20180816024410.29218-1-andrew.smirnov@gmail.com>
Message-ID: <nycvar.YFH.7.76.1809051020420.15880@cbobk.fhfr.pm>
References: <20180816024410.29218-1-andrew.smirnov@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018, Andrey Smirnov wrote:

> This is v2 of the patches adding support for rumble for Xbox One S
> controller connected over Bluetooth. Hopefully all of the changes are
> pretty straightforward and self-explanatory.

Applied to for-4.20/microsoft branch. Thanks,

-- 
Jiri Kosina
SUSE Labs

