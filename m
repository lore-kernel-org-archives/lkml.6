Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92334C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5052120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5052120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeIZCtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:49:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33137 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIZCtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:49:45 -0400
Received: from null ([172.19.249.154]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M6YEz-1g7LtV24bZ-006tSS; Tue, 25
 Sep 2018 22:39:48 +0200
Date:   Tue, 25 Sep 2018 22:39:47 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <39545838.286987.1537907987266@email.1und1.de>
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Subject: Re: [PATCH v3 0/2] staging: bcm2835-camera: Clean up completed TODO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:e7UVsrQh32QpZgxMITNGx1HuohIGYzJzpJvsQcxIxwmXxLcTXkJ
 f4x74pb53vfpP+luMO4a99H7oFTb3VHhqNw/iGZV6D/aLV/b//vqh1Mde4Uldb2prjjt8JF
 vrqFHhwNF1oeBzBZD9LCxdJv+tqWuNDt7tbhy93C803xMwo25Uv/ipRA6lNfQmJUgPrAB6+
 /bkQwYfQj5QvjdMj0RiCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:viJqyI8f3/0=:bmcPlRg9OPo/OiqggSoh3G
 hausvMD+8qCfmTz36sRn1WPoECZA656YDSEOfSHCK3HsINQoF9r2/SpVhxMWZ/yai++t64Hn1
 LtsdbIbfuLzcAVU9e6XA6Se5d38Q1yJH2gm+OHGQf8ZkgkYuiOo5L8OVqS/rvpnmsCQtM1XCh
 fQkI/Y8TxrHoX3uMM4Zku/lGRhFJT1sEsz4q6VyG9QHmhc9uMOTFI0mgtOMWadPi0b1E9/qUU
 sMnxTm+oQZx0fHyF2I6xvitkiStV9u6hL/kjMV8kCZQnHCbxrDJXznGX1NlyGwmQ2FPq32FC1
 m/Yvlekt9jaK9WVQaBXt2YtLxAYx22vRxsInbadFFi7NlBvPT90ohi8oswPDh3B32fr790QVB
 3TQDNHaINlyMdP7FSYoo4UnK5Yb1avLJ02S8HgBy64Ey8yWUnHjwvvIleh2flKRoilS8kHv8f
 2pg8fg45l7k9ZogTtzvhTgXlE+QouIgr5zFNBAQJDJsHiauVrzAM9FT9wEsizmMxmhOcke8Bo
 P9e/nO9mmvNpNKeiXeQpgGRSzkhLeTNBS70hxE2X5K+15nYvhmu7CvOfcCDmXJE9ahCEPvxg9
 J4+sjqyiBOQ5Ss4ELLL5D3YkmUB6fUo2LHk2fWi6gQaHrpU7YQP9Szlud8vk9cidrUxBG6uXr
 g/olcElGcUcb0/Vy8bO8EY5wfRRT3mMRvEusgzx36BalBmrMuP4IcAw7zrcENtPMiXXB9zMVR
 PRi/g3uWr7zs9E5S
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Aymen Qader <qader.aymen@gmail.com> hat am 25. September 2018 um 10:33 geschrieben:
> 
> 
> Update the bcm2835-camera driver to remove a TODO and an unused header
> include. These were made unnecessary in
> 
> commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
> flush operations")
> 
> Aymen Qader (2):
>   staging: bcm2835-camera: Update TODO
>   staging: bcm2835-camera: Remove unused header

The whole series is

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
