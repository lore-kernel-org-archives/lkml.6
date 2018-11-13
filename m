Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CB62245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CB62245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbeKMUby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:31:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:57146 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbeKMUby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:31:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 02:34:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,498,1534834800"; 
   d="scan'208";a="91648369"
Received: from sidorovd-mobl.ccr.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.53.165])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2018 02:34:20 -0800
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 27BC521DB6; Tue, 13 Nov 2018 12:34:14 +0200 (EET)
Date:   Tue, 13 Nov 2018 12:34:14 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: media: Add Allwinner A10 CSI binding
Message-ID: <20181113103413.imvwqplpxdhqeag3@kekkonen.localdomain>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <60494dd4245ab01473d074dc5cd46198a2181614.1542097288.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60494dd4245ab01473d074dc5cd46198a2181614.1542097288.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Nov 13, 2018 at 09:24:13AM +0100, Maxime Ripard wrote:
> The Allwinner A10 CMOS Sensor Interface is a camera capture interface also
...
> +Optional properties:
> +  - allwinner,csi-channels: Number of channels available in the CSI
> +                            controller. If not present, the default
> +                            will be 1.

Is this virtual channels or something else btw.?

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
