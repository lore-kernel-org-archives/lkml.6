Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeCIN7E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:59:04 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:57301 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751056AbeCIN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:59:03 -0500
Subject: Re: [PATCH v6 06/17] media: rkisp1: add ISP1 statistics driver
To: Jacob Chen <jacob-chen@iotwrt.com>, linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        tfiga@chromium.org, zhengsq@rock-chips.com,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Jacob Chen <cc@rock-chips.com>,
        Allon Huang <allon.huang@rock-chips.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-7-jacob-chen@iotwrt.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <afc8a814-be1b-39ce-73b7-a40ebc216d63@xs4all.nl>
Date: Fri, 9 Mar 2018 14:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308094807.9443-7-jacob-chen@iotwrt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL47fDLeL9dLf07A17siUhlUxMu8cRyYf/RBFH2gyj6epEtW65JFt9N/T8JuGw0EzV6fJIzpR5H/eUebpAZCY9+lEe5p9NvoH1LQU05Durorg/JK+408
 wouJQ7CPC2A504ShTI8leUPYIRVAJW2II8m2uObZVr7acKlCHVXSy/0CBvfoD352nsvj87ug0ubheXiIs7SPChpWz3J9+gR85zVo/rxpFYT2N4pceNCIU9Jl
 C/GEXBv3jhObZC07pPB0aTbdBSkSBVp30NwU7CrvI94LceW50eJMYbwW70fOZXdaULwtj1uj4fFGIz66NqMpcPkRJemRDTSeOyah8Sl3cOnHNrsCN8I30sk5
 lNPk1UfNDm2Xz0JIFLo4TEEnpuJSeol5BNLj+/+9bUUwJUcxkz3SvccSTJGH5m3pWK5j3Dpby0A/usc7wDWSPWwk+HvrZBV4iG5TEtV9ORh9TqvwWTzvKGvk
 YSpoAHva32JD98rNyzMsNpPRWtcPrdXlZ985edsVDf8i2pzn+NhAg2kVtj1C6bFUbJzZQX0vM00ByBXprSnchCMXb2cKqVLKoJojjZKRKiqOQIwNCbcEZvE2
 WQKhZ+42WIhV+jgadCR+DNPvQAXzTOoKlnHRhbFBCoo8jKxJ7LHrAq5jN8aB5ufBtI+UuBmnatfDUVH5Eox9i1aX/ma6FPRIcm2L26qf/m/zjjAtfDzLC3ty
 fzvd7PMUKuFA/W+1WsDDeHKHOQcUhRB210+mOb5xnRZG9ZM9FpiYqf0JjG2Q6gjmECVlp1hAHjQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/18 10:47, Jacob Chen wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> Add the capture video driver for rockchip isp1 statistics block.
> 
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Yichong Zhong <zyc@rock-chips.com>
> Signed-off-by: Jacob Chen <cc@rock-chips.com>
> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Allon Huang <allon.huang@rock-chips.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
