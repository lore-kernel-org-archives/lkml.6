Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C9C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F99820866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F99820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeILA1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:27:44 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51255 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeILA1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:27:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fzoJM-00012D-Os; Tue, 11 Sep 2018 20:26:56 +0100
Message-ID: <1536694015.3024.141.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 40/79] ARM: imx_v6_v7_defconfig: Select ULPI support
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Date:   Tue, 11 Sep 2018 20:26:55 +0100
In-Reply-To: <20180823074921.706703657@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
         <20180823074921.706703657@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 09:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me
> know.
> 
> ------------------
> 
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> [ Upstream commit 157bcc06094c3c5800d3f4676527047b79b618e7 ]
> 
> Select CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS so that
> USB ULPI can be functional on some boards like imx51-babbge.
[...]

CONFIG_USB_CHIPIDEA_ULPI doesn't exist in 4.4 or 4.9, so I think this
and commit 2ceb2780b790b "ARM: imx_v4_v5_defconfig: Select ULPI
support" should be reverted on those branches.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
