Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC28C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3D32064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3D32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeJOU04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:26:56 -0400
Received: from ni.piap.pl ([195.187.100.4]:43086 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeJOU04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:26:56 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTP id B8A64440E08;
        Mon, 15 Oct 2018 14:41:45 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: net/wan: hostess_sv11 + z85230 problems
References: <1468d110-4f92-da7a-21b5-36afcec3c94e@infradead.org>
        <m34ldnd3ju.fsf@t19.piap.pl> <20181015112910.4504cd3a@alans-desktop>
Date:   Mon, 15 Oct 2018 14:41:44 +0200
In-Reply-To: <20181015112910.4504cd3a@alans-desktop> (Alan Cox's message of
        "Mon, 15 Oct 2018 11:29:10 +0100")
Message-ID: <m3zhvfbcvr.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, not scanned, whitelist
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <gnomes@lxorguk.ukuu.org.uk> writes:

>> BTW Hostess SV11 is apparently an ISA card, with all those problems.
>
> Actually it worked perfectly well of old but people kept changing it
> who didn't have hardware.

Right, that's the same with all of this hardware.

In fact I meant all the ISA problems (in comparison to e.g. PCI),
not of any particular design.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
