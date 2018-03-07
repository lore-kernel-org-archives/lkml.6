Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeCGDNf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 22:13:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36206 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbeCGDNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 22:13:33 -0500
To: Jeremy Cline <jeremy@jcline.org>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lining916740672@icloud.com
Subject: Re: [PATCH v2] scsi: sd: Keep disk read-only when re-reading partition
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <01000161fd48a4af-94cc485f-468a-404a-985e-7e8e50a358f0-000000@email.amazonses.com>
Date: Tue, 06 Mar 2018 22:13:25 -0500
In-Reply-To: <01000161fd48a4af-94cc485f-468a-404a-985e-7e8e50a358f0-000000@email.amazonses.com>
        (Jeremy Cline's message of "Tue, 6 Mar 2018 21:47:32 +0000")
Message-ID: <yq1vae8o9wq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=388
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jeremy,

> Sorry about this, but there's a bug in the first version of this patch.
> I'm not sure what the protocol is for sending revised patches when the
> earlier version got accepted, but I don't see the first version in
> 4.16/scsi-fixes yet.

It's your lucky day! I botched fixing up something the other day and as
a result the tree was never pushed.

v2 added to 4.16/scsi-fixes.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
