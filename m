Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeEVVUI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:20:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752660AbeEVVUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:20:06 -0400
Date: Tue, 22 May 2018 16:03:06 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] scsi: cxlflash: Drop unused sense buffers
References: <20180522181512.39316-1-keescook@chromium.org>
 <20180522181512.39316-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522181512.39316-3-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18052221-0008-0000-0000-0000030E0123
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009066; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036097; UDB=6.00530006; IPR=6.00815225;
 MB=3.00021242; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 21:20:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052221-0009-0000-0000-0000395A458E
Message-Id: <20180522210306.GA60047@p8tul1-build.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:15:08AM -0700, Kees Cook wrote:
> This removes the unused sense buffer in read_cap16() and write_same16().
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good.

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
