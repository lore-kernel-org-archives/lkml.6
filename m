Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24403C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B4C20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B4C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeGYPtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:49:00 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:42058 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728631AbeGYPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:48:59 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 6CF77B0007C;
        Wed, 25 Jul 2018 14:37:00 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1044.25; Wed, 25 Jul 2018 07:36:56 -0700
Subject: Re: [PATCH net-next 1/2] docs: Add rest label
 the_canonical_path_format
To:     "Tobin C. Harding" <me@tobin.cc>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180725025005.14332-1-me@tobin.cc>
 <20180725025005.14332-2-me@tobin.cc>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <010bd587-6e4d-549e-e613-cb785f614463@solarflare.com>
Date:   Wed, 25 Jul 2018 15:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180725025005.14332-2-me@tobin.cc>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-23990.005
X-TM-AS-Result: No-2.369500-4.000000-10
X-TMASE-MatchedRID: e/tT8EyIjJQOwH4pD14DsPHkpkyUphL9FuNF4lJG6xswplGJ7NxS05m3
        CkZsyRGFaLzRdTLrOfPM9+oUDdmM35H0YXYnbGozOX/V8P8ail1yZ8zcONpAsdmzcdRxL+xwKra
        uXd3MZDVAm9Oi0yGWXUGkxm71XmgjlLBg6Aapj8e0svHlCOwXYb9prM1hh5sihXICXPkDTMLvGy
        aLyWJvBWLqcdF40kDywzhVZiqhieGz597RaJ+lCg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.369500-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-23990.005
X-MDID: 1532529421-qwnbzk7DGaJe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/18 03:50, Tobin C. Harding wrote:
> In preparation to convert Documentation/network/netdev-FAQ.rst to
> restructured text format we would like to be able to reference 'the
> canonical patch format' section.
>
> Add rest label: 'the_canonical_path_format'.
Here and in the Subject, 'patch' is typoed as 'path'.
