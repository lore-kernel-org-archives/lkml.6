Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeB0PHO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:07:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753896AbeB0PHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:07:11 -0500
Subject: Re: [PATCH v2] x86/xen: add tty0 and hvc0 as preferred consoles for
 dom0
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: jbeulich@suse.com
References: <20180227101922.15701-1-jgross@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <26b96ce9-b462-c4e3-b939-4c152040255d@oracle.com>
Date: Tue, 27 Feb 2018 10:07:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180227101922.15701-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=638
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802270190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 05:19 AM, Juergen Gross wrote:
> Today the tty0 and hvc0 consoles are added as a preferred consoles for
> pv domUs only. As this requires a boot parameter for getting dom0
> messages per default, add them for dom0, too.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
