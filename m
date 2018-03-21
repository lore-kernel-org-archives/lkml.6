Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeCUWsD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:48:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753845AbeCUWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:48:01 -0400
To: Ching Huang <ching2048@areca.com.tw>
Cc: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, hch@infradead.org, colin.king@canonical.com
Subject: Re: [PATCH 0/4] scsi: arcmsr: Support Areca thunderbolt devices hot-plug
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1521095129.31371.25.camel@Centos6.3-64>
Date: Wed, 21 Mar 2018 18:47:22 -0400
In-Reply-To: <1521095129.31371.25.camel@Centos6.3-64> (Ching Huang's message
        of "Thu, 15 Mar 2018 14:25:29 +0800")
Message-ID: <yq17eq5rqpx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=373
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ching,

> 1. Rename ACB_F_BUS_HANG_ON to ACB_F_ADAPTER_REMOVED for adapter hot-plug
> 2. Handle adapter removed due to thunderbolt cable disconnection.
> 3. Sleep to avoid CPU stuck too long for waiting adapter ready
> 4. Change driver version to v1.40.00.05-20180309

Applied to 4.17/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
