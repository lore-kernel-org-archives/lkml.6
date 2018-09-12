Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA3C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB7F20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB7F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeILNcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:32:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:32:03 -0400
Received: from [192.168.178.69] ([109.104.39.184]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mqrjz-1fVOqz22qX-00mpRw; Wed, 12 Sep 2018 10:28:12 +0200
Subject: Re: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <d989e700-0cf1-607a-b333-bdead49ae813@i2se.com>
Date:   Wed, 12 Sep 2018 10:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:dAw+u7ndiQZ/L+MJ6l1yCMeg9JQFupYFGNa71/HVxg8yD4td5m0
 IWOKLvz9y3Kv61BwUACtHpGI2rpctVXU6rSPUj42R+n0zQ/C5d/7K8phurNjVN40wqACfLA
 TAvNIEMdNicN9SMKJzysBxa7pJX0Rqg29aAMbXBiS5S5Z2a84oaD5gpyA7rf9XY2PZQEOf2
 QQezcAiDaj8RZbbcETCkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uZNvE04az2k=:tfgaWOEy+LoRJ9louWUyk9
 PqslDihoHYSt176dOsNo7kFWqoKYMFW6MQzYw4kRIf/CAkX90Xz61R7I0ayDJpJHF+7+m9qVz
 yzBxwc3yzx8qMtsX2hyUaWzdXJlpHrERcZjoVyZq9sWc4ey0gaebuuz+I72Lhe2RVmC3ZQlOj
 RBrkmoRA2rkn+c8tkElj0v5L+YGkDW+lOlxRgUkgLdp3ebZBdiRixpaSQUp2LVYa2WCG4vpaS
 91L2RRO7VlJWJ53+HsQZZTQoPzt/2MvzrkXbdgjdm+xqdAaz3REGGhCGLPHN+GfZpACL3Xx9i
 wfQPRQvd5rm66c9d0hupQuwGOi/q8czZ9rfznS9UtzcjEYc215dU3GUn4gfvBQpCzHoeR0G4X
 Ly98lPt34LUkEBhByi6hY3Hz6+XFjx62JmrsA89Ioz3Of9uCcpBMqSStOoqWXzlJssd0o2Abl
 LWkhzH7WBdraoeCKURiXlAUfzXP1ZyLdpTPlynxB7TYpnlVIwvkT0r4O2bLOZVmWdtVS3PeIM
 cRzksZ1XTCD7HJFb8NhXwnMwTUmGubZ7WfEY5qX5Uri8ZM6cpUa0HnMBbGSRzJRhdOZYEJAja
 V39nbb5ajWthAU1dZ6dX7jDoRKa3GF7D8Lfku/gtLCs89Mf0+vUsF5BZg/crVU573RMUxWrxU
 pSnYMvQkXLyIki4aU+63pNfjo8kcw2knXoOZ7Q5o/IlUJrmWpOL2AfQm6VJlDrBei2KANwMh5
 PZ0oe+FYLx+6cNDG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

Am 12.09.2018 um 10:13 schrieb Anson Huang:
> Update VDD_SOC voltage to 1.25V for 900MHz operating point
> according to datasheet Rev. 1.3, 08/2018, 25mV is added to
> the minimum allowed values to cover power supply ripple.

is there a reason why the new datasheet isn't published yet?

Regards
Stefan

