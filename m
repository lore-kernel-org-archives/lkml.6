Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeERQGS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:06:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38912 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:06:14 -0400
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: dpt_i2o: Remove VLA usage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180502222138.GA22088@beast>
        <CAGXu5jJSQa8WNEOSX7qaPWnGwArx4=X01S+82DQakHP_VY23VA@mail.gmail.com>
Date: Fri, 18 May 2018 12:06:02 -0400
In-Reply-To: <CAGXu5jJSQa8WNEOSX7qaPWnGwArx4=X01S+82DQakHP_VY23VA@mail.gmail.com>
        (Kees Cook's message of "Fri, 18 May 2018 08:12:29 -0700")
Message-ID: <yq1po1teyol.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=717
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

>> On the quest to remove all VLAs from the kernel[1] this moves the sg_list
>> variable off the stack, as already done for other allocated buffers in
>> adpt_i2o_passthru(). Additionally consolidates the error path for kfree().
>
> Friendly ping! How does this look for v4.18?

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
