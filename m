Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeBGMAb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:00:31 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:50914 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753738AbeBGMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:00:29 -0500
Subject: Re: [PATCH v5 03/16] media: rkisp1: Add user space ABI definitions
To: Shunqian Zheng <zhengsq@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        allon.huang@rock-chips.com, devicetree@vger.kernel.org,
        heiko@sntech.de, robh+dt@kernel.org, Joao.Pinto@synopsys.com,
        Luis.Oliveira@synopsys.com, Jose.Abreu@synopsys.com,
        jacob2.chen@rock-chips.com
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <e6160bef-29af-3905-6535-a18cb0caa601@xs4all.nl>
Date: Wed, 7 Feb 2018 13:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA/FUoZR2t9WIs/+q42pocHGYxK03AevDX76RIMXgF1QcoEAeiI5KYf+oqFPvwDraXrdXHFH4ia/YRkX1H/8nBJWfRry89vVUkhNBJPBQygJfbNCmFdu
 rAWM9rSh+VuAKfS9sPOQMo7C6ZBeD+t2pLBF51Jg9XA/ohzDqvI0VbistdSTab1J+GCiqm9l4FqpYjfK/RWUGc7zPLVmANAQQvNI3Rw0NhWBc21tUSubDPzy
 uPqQk4fRl2Xkr1JIW1M9V0lLS6giFHStEd1HZwzkZ+w5y85YtTmdNjeFQQbYrVaNwMxa5XKgOwFtR846gmwEXQcMzpMyIsHUHKOjGqPV+DEqXss3hMcZr6Vu
 ti6lVFa2bJhr//VuG9xcHn8BoTV+R07eJOQLvV3NFanEff5ENkAynBnjv3gnHIMyBKirMjyROSnkLVjf92vVPEN9mBH2zGhlE28bi6hTocL1yhCJBsDWaD9q
 R2EX2o1Zg+UgTeaHUGeV1KCzTsa0FIs7txQ+MMbr7O+0uQOHuEDeEmvWvFedv1Ee+NmoG/Jn1ErT/3TjEMyWG9w5YcliclQOaS3IxHKNm6HWHUeFiIEBFHON
 FVEjgsB/ycGxk3FIBOMxigiCKbre6zo9yud7n2gfyZ9XOyrwjZCYTZ7OCDKMwRJ0Ku/UOSJDdjazGsBRNoaU/BEaF/ELEduAkWjNMWEJAmq2AqvMm/VdsTZX
 4Fo8VJyi/YzVXdAgaGKN/GrRpsoKClFddEJTFh6+QLzqGoQ+nCavTk/Ui3xoTAFUZIfDciThONlKaDjgLzVXyzEvA82S0l1ty1tLZU16TNUR9Dzc0EWijsn4
 TWopvHqseFbeOsgPmRgP8SsHx0tMCim7pIpUJCJU4HzEjPZRczQ+bvEs1VmxLnCGE0Hkm1uLKnZaky6tUkSY0y/jV2UhVZCBd/zZHBu2nc3QaIvX8c35s7qz
 4z8RzGTrf5LnPl+bsj/8KkgqJRo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/17 08:52, Shunqian Zheng wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Add the header for userspace

General note: I saw four cases where this documentation referred to the
datasheet. Three comments on that:

1) You don't say which datasheet.
2) I assume the datasheet is under NDA?
3) You do need to give enough information so a reasonable default can be
   used. I mentioned in an earlier review that creating an initial params
   struct that can be used as a templete would be helpful (or even
   required), and that would be a good place to put such defaults.

Regards,

	Hans
