Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeDTRZL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:25:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeDTRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:25:10 -0400
Subject: Re: [PATCH v2 0/2] memory: aemif: add support for machine code
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180419151252.26212-1-brgl@bgdev.pl>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <0f2903da-b670-dc85-e61b-64cac90a6c34@oracle.com>
Date: Fri, 20 Apr 2018 10:24:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419151252.26212-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=893
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/18 8:12 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is a follow-up to the series that contained both changes to the
> aemif driver and platform code. It contains only the driver changes.
> 
> As the first step in removing duplicate support for aemif from the
> kernel we need to add support for board files to the aemif memory
> driver.
> 
> First patch just uses a static string for the ti-aemif driver name.
> 
> The second adds support for board files to the aemif driver.
> 
> This series includes changes requested by Sekhar in his code review:
> - made aemif the parent of each sub-device before registering it
> - documented the new members in aemif_platform_data
> 
> v1 -> v2:
> - actually iterate over abus entries instead of always accessing the
>    first one
> 
> Bartosz Golaszewski (2):
>    memory: aemif: don't rely on kbuild for driver's name
>    memory: aemif: add support for board files
> 
Applied. Should show up in next soon.

Sekhar, You can use below branch.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git 
  'for_4.18/soc-drivers'
