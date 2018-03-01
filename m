Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935732AbeCACOq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:14:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935682AbeCACOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:14:45 -0500
Subject: Re: [PATCH v2] pvcalls-front: 64-bit align flags
To: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.1802281803430.4239@sstabellini-ThinkPad-X260>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <f7c47593-8f1d-3607-a50f-9659e65e4319@oracle.com>
Date: Wed, 28 Feb 2018 21:14:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802281803430.4239@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=697
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/28/2018 09:05 PM, Stefano Stabellini wrote:
> We are using test_and_* operations on the status and flag fields of
> struct sock_mapping. However, these functions require the operand to be
> 64-bit aligned on arm64. Currently, only status is 64-bit aligned.
> 
> Make status and flags explicitly 64-bit aligned.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
