Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeEHF0H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:26:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEHF0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:26:06 -0400
To: Andrei Vagin <avagin@openvz.org>
Cc: qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: remove the unused tcm_qla2xxx_cmd_wq
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180502203113.13183-1-avagin@openvz.org>
Date: Tue, 08 May 2018 01:25:53 -0400
In-Reply-To: <20180502203113.13183-1-avagin@openvz.org> (Andrei Vagin's
        message of "Wed, 2 May 2018 13:31:13 -0700")
Message-ID: <yq18t8uyazi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=465
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080052
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrei,

Applied to 4.18/scsi-queue. thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
