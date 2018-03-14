Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCNNo4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:44:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeCNNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:44:54 -0400
To: John Pittman <jpittman@redhat.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_dh_alua: Correct comment for alua_alloc_pg()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1521034825-26467-1-git-send-email-jpittman@redhat.com>
Date: Wed, 14 Mar 2018 09:44:47 -0400
In-Reply-To: <1521034825-26467-1-git-send-email-jpittman@redhat.com> (John
        Pittman's message of "Wed, 14 Mar 2018 09:40:25 -0400")
Message-ID: <yq1d106db5c.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> In the comment for function alua_alloc_pg() the argument '@h' is
> mistakenly referred to.  Fix this by replacing it with the correct
> argument reference, '@tpgs', and provide a short description.

Please submit to linux-scsi@vger.kernel.org. Otherwise the patch won't
get picked up by patchwork.

-- 
Martin K. Petersen	Oracle Linux Engineering
