Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeCGQzG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:55:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58636 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933956AbeCGQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:54:56 -0500
Subject: Re: [GIT PULL 2/2] SOC: Couple of drivers changes for v4.17
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1520296873-12982-1-git-send-email-santosh.shilimkar@oracle.com>
 <1520296873-12982-2-git-send-email-santosh.shilimkar@oracle.com>
 <CAK8P3a3HbkMJsppb4jN-755T-8CyASsN7kJ1ZLTg31XXeBnO=A@mail.gmail.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <dd550f16-00cd-2c66-1a9e-dfbb02a6418b@oracle.com>
Date: Wed, 7 Mar 2018 08:54:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3HbkMJsppb4jN-755T-8CyASsN7kJ1ZLTg31XXeBnO=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=649
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070194
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/18 7:50 AM, Arnd Bergmann wrote:
> On Tue, Mar 6, 2018 at 1:41 AM, Santosh Shilimkar
> <santosh.shilimkar@oracle.com> wrote:
>> The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:
>>
>>    Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.17
>>
>> for you to fetch changes up to a817e5d82a2dc5daaa0a8a66cfab268fdf2f6bb6:
>>
>>    memory: ti-emif-sram: remove redundant dev_err call in ti_emif_probe() (2018-03-05 16:21:31 -0800)
>>
>> ----------------------------------------------------------------
>> SOC driver changes for v4.17
>>
>>   - Remove deundant dev_err from probe in ti-emif-srma driver
>                       ^^ I fixed the typo while applying
> 
Thanks Arnd !!

Regards,
Santosh
