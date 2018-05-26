Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeEZEoC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 00:44:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33870 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeEZEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 00:44:01 -0400
Subject: Re: [PATCH 0/3] Dts nodes for Keystone2 hw_rng driver
To: Vitaly Andrianov <vitalya@ti.com>, ssantosh@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: m-karicheri2@ti.com
References: <1527167538-29837-1-git-send-email-vitalya@ti.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <45e0a1c8-739e-0a38-bd86-047c37551f62@oracle.com>
Date: Fri, 25 May 2018 21:43:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527167538-29837-1-git-send-email-vitalya@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8904 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=666
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805260053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/18 6:12 AM, Vitaly Andrianov wrote:
> This series adds dts nodes for Keystone2 hw_rng driver
> 
> Vitaly Andrianov (3):
>    ARM: dts: k2hk: add dts node for k2hk hw_rng driver
>    ARM: dts: k2l: add dts node for k2l hw_rng driver
>    ARM: dts: k2e: add dts node for k2e hw_rng driver
> 
Looks good. Will queue this up for 4.19. Thanks !!

Regards,
Santosh
