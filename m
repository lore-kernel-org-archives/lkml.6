Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeEUDSA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 23:18:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34746 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeEUDR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 23:17:58 -0400
Subject: Re: [linux-next PATCH 0/4] Enable network driver on K2G ICE and GP
 EVMs
To: Murali Karicheri <m-karicheri2@ti.com>, ssantosh@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
Date: Sun, 20 May 2018 20:17:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8899 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805210037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/18 12:29 PM, Murali Karicheri wrote:
> Now that NetCP driver patches for K2G SoC is merged to linux-next master
> this series add patches to enable network driver on K2G ICE and GP EVMs.
> 
> Thanks
> 
> Applied the patches on top of latest linux-next master, built kernel and
> booted up on both EVMs. The logs are below
> 
> K2G GP EVM: https://pastebin.ubuntu.com/p/ycZDnZXYPx/
> K2G ICE EVM: https://pastebin.ubuntu.com/p/bdCpzgdrXr/
> 
> Murali Karicheri (4):
>    ARM: dts: k2g: add dt bindings to support network driver
>    ARM: dts: keystone-k2g-evm: Enable netcp network driver
>    ARM: dts: keystone-k2g-ice: Enable netcp network driver
>    ARM: keystone: k2g: enable micrel and dp83867 phys
> 
>   arch/arm/boot/dts/keystone-k2g-evm.dts    |  53 +++++++++++
>   arch/arm/boot/dts/keystone-k2g-ice.dts    |  59 ++++++++++++
>   arch/arm/boot/dts/keystone-k2g-netcp.dtsi | 147 ++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/keystone-k2g.dtsi       |  13 +++
>   arch/arm/configs/keystone_defconfig       |   2 +
>   5 files changed, 274 insertions(+)
>   create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi
> 
Looks good. Will add this to the queue for 4.19. Thanks !!

Regards,
Santosh
