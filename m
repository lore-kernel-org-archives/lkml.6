Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E7EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF26621A76
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF26621A76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGDSdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:33:37 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:48793 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752598AbeGDSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:33:35 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 14:33:34 EDT
Received: from [IPv6:2003:e9:d74b:8cb:3252:cbff:fe54:190f] (p200300E9D74B08CB3252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:e9:d74b:8cb:3252:cbff:fe54:190f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 03035C7FC7;
        Wed,  4 Jul 2018 20:26:13 +0200 (CEST)
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        lora@radioshuttle.de, Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20180701110804.32415-1-afaerber@suse.de>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
Date:   Wed, 4 Jul 2018 20:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 01.07.2018 13:07, Andreas Färber wrote:
> 
> This patchset, updated from 2017 and extended, is implementing kernel drivers
> for various LoRa chipsets and modules.

I am very happy to see that we now have three people (you, Jian-Hong and
Ben) working towards a lora subsystem for protocol stack and drivers.

Will allocate some time to look over this and provide some review and
feedback how we handled things in the ieee802154 and 6lowpan subsystems.

We are also having a IoT protocols workshop during NetDev Conf next week
in Montreal (short notice if you are not already planning to attend). If
you (or Ben) has soem topics wanted to bring up their please let me know
by pm. Jian-Hong will be there presenting on his lora work and I would
love to get more input from you and Ben on your views on this.

https://netdevconf.org/0x12/session.html?workshop-on-iot-related-mac-layers-header-compression-and-routing-protocols

regards
Stefan Schmidt
