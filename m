Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeCVBOu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:14:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45270 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeCVBOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:14:48 -0400
Subject: Re: [PATCH v3] drm/xen-front: Add support for Xen PV display frontend
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1521644293-14612-1-git-send-email-andr2000@gmail.com>
 <1521644293-14612-2-git-send-email-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <d7cd6147-da9f-0f18-cb05-4dccbf212255@oracle.com>
Date: Wed, 21 Mar 2018 21:14:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521644293-14612-2-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2018 10:58 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Add support for Xen para-virtualized frontend display driver.
> Accompanying backend [1] is implemented as a user-space application
> and its helper library [2], capable of running as a Weston client
> or DRM master.
> Configuration of both backend and frontend is done via
> Xen guest domain configuration options [3].


I won't claim that I really understand what's going on here as far as 
DRM stuff is concerned but I didn't see any obvious issues with Xen bits.

So for that you can tack on my
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
