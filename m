Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163911AbeCBB7A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 20:59:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163254AbeCBB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 20:58:54 -0500
To: Jeremy Cline <jeremy@jcline.org>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: Keep disk read-only when re-reading partition
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <01000161e1e448a5-d54e05d2-58f2-4480-b05b-67185d4ffae7-000000@email.amazonses.com>
Date: Thu, 01 Mar 2018 20:53:46 -0500
In-Reply-To: <01000161e1e448a5-d54e05d2-58f2-4480-b05b-67185d4ffae7-000000@email.amazonses.com>
        (Jeremy Cline's message of "Thu, 1 Mar 2018 14:08:10 +0000")
Message-ID: <yq1vaefxmxh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=514
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jeremy,

Thanks for looking into this!

> This commit reads the disk's old state and combines it with the device
> disk-reported state rather than unconditionally marking it as RW.

Applied to 4.16/scsi-fixes with a few minor tweaks. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
