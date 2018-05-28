Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeE1CTK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 22:19:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753115AbeE1CTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 22:19:07 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc-opal: fix spelling mistake "Uniterrupted" -> "Uninterrupted"
In-Reply-To: <20180526151531.10920-1-colin.king@canonical.com>
References: <20180526151531.10920-1-colin.king@canonical.com>
Date: Mon, 28 May 2018 12:18:55 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18052802-0056-0000-0000-000004579C1F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009094; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000262; SDB=6.01038674; UDB=6.00530875; IPR=6.00817803;
 MB=3.00021330; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-28 02:19:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052802-0057-0000-0000-0000089BBDFE
Message-Id: <8736ycr08g.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in hmi_error_types text
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Stewart Smith <stewart@linux.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
