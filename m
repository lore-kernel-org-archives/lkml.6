Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17415C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA67820878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA67820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeLEMQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:16:57 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:48779 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeLEMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:16:57 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gUW6q-0006AR-JZ from Jiada_Wang@mentor.com ; Wed, 05 Dec 2018 04:16:56 -0800
Received: from [172.30.112.81] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 5 Dec
 2018 04:16:53 -0800
Subject: Re: [PATCH linux-next v3 7/7] clk: renesas: Add binding document for
 ADG
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181205074947.28151-1-jiada_wang@mentor.com>
 <87tvjsbbgh.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <3b2941db-4cd5-0975-c88d-4a23c1ff4907@mentor.com>
Date:   Wed, 5 Dec 2018 21:16:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87tvjsbbgh.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san

will rename dt bindings doc in next version

Thanks.
Jiada

On 2018/12/05 18:04, Kuninori Morimoto wrote:
> Hi Jiada
>
>> Add device tree bindings for Audio Clock Generator (ADG)
>> of R-Car Socs.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   .../clock/renesas,rcar-adg-clocks.txt         | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt
> We want to have this document on rsnd.txt instead of
> not-exist-driver file
>
> 	/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
>
> Best regards
> ---
> Kuninori Morimoto

