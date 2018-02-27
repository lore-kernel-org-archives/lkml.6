Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeB0ATV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:19:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35624 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeB0ATT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:19:19 -0500
Subject: Re: [PATCH v5 0/4] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume
 support
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
References: <20180223154357.23504-1-d-gerlach@ti.com>
 <a56830af-cf81-3603-ba58-2a2c65c49f34@oracle.com>
 <20180226212650.GB16043@atomide.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <58006020-85d9-9681-f80a-2f9eda1e863a@oracle.com>
Date: Mon, 26 Feb 2018 16:18:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226212650.GB16043@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802270002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/18 1:26 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@oracle.com> [180225 23:36]:
>>> Dave Gerlach (4):
>>>     ARM: OMAP2+: Introduce low-level suspend code for AM33XX
>>>     ARM: OMAP2+: Introduce low-level suspend code for AM43XX
>>>     ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
>>>     soc: ti: Add pm33xx driver for basic suspend support
>>>
>> Are you going to pickup this series ?
> 
> Yes planning to apply it today or tomorrow.
> 
Sounds good.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
