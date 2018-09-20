Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FDBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD6D20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD6D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeITVOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:14:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19478 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387549AbeITVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:14:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8KFOMHH030922;
        Thu, 20 Sep 2018 17:30:07 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mgqhwq8kv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 20 Sep 2018 17:30:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41AED38;
        Thu, 20 Sep 2018 15:30:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27A4253F8;
        Thu, 20 Sep 2018 15:30:07 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 20 Sep
 2018 17:30:06 +0200
Subject: Re: [PATCH] ARM: dts: stm32: enable display on stm32mp157c-ev1 board
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
References: <1534856316-30346-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <32af7fbb-3734-1b06-488f-efe7e17bae25@st.com>
Date:   Thu, 20 Sep 2018 17:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534856316-30346-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 08/21/2018 02:58 PM, Yannick Fertré wrote:
> Enable panel raydium RM68200, DSI bridge & display controller.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---

Applied on stm32-next.

Thanks.
Alex

