Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965413AbeBMRA6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:00:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54778 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965144AbeBMRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:55 -0500
Subject: Re: [PATCH] clk: keystone: sci-clk: add support for dynamically
 probing clocks
To: Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, ssantosh@kernel.org,
        mturquette@baylibre.com
References: <1518540942-25213-1-git-send-email-t-kristo@ti.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <1d8bf56f-422e-29fc-e2e6-278f2c298e3f@oracle.com>
Date: Tue, 13 Feb 2018 09:00:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518540942-25213-1-git-send-email-t-kristo@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 8:55 AM, Tero Kristo wrote:
> Currently, the driver contains a large hints table for clocks that exist
> on a device, however, it is possible to probe the clocks from the firmware
> also. Add support for this, and drop the clock hints table support from
> the driver completely. This causes the driver to send a few extra sci-clk
> messages during boot, basically one extra for each device that exists on
> the SoC; on K2G this is approx 80.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
