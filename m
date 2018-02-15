Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164618AbeBOXVL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:21:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163785AbeBOXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:21:09 -0500
To: Colin King <colin.king@canonical.com>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_transport_spi make two const arrays static, shrinks object size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180214223543.23237-1-colin.king@canonical.com>
Date: Thu, 15 Feb 2018 18:21:02 -0500
In-Reply-To: <20180214223543.23237-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 14 Feb 2018 22:35:43 +0000")
Message-ID: <yq1o9kplu01.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=727
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150277
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Don't populate the const read-only arrays spi_test_unit_ready and
> spi_test_unit_ready on the stack but instead make them static. Makes the
> object code smaller by over 100 bytes:

Applied to 4.17/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
