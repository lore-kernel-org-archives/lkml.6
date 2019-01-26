Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE0C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E5F218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAZP6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:58:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbfAZP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:58:41 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0QFnEH7072440
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 10:58:40 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q8hc97gj0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 10:58:40 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 26 Jan 2019 15:58:39 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 26 Jan 2019 15:58:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0QFwaMK23265382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Jan 2019 15:58:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58125B2064;
        Sat, 26 Jan 2019 15:58:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A075B205F;
        Sat, 26 Jan 2019 15:58:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.216.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 26 Jan 2019 15:58:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 113A216C6997; Fri, 25 Jan 2019 22:30:38 -0800 (PST)
Date:   Fri, 25 Jan 2019 22:30:38 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] Korean translation of memory-barriers.txt update
Reply-To: paulmck@linux.ibm.com
References: <20190124215548.4991-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124215548.4991-1-sj38.park@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012615-2213-0000-0000-000003451459
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010481; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01152095; UDB=6.00600533; IPR=6.00932445;
 MB=3.00025301; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-26 15:58:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012615-2214-0000-0000-00005D1F73AC
Message-Id: <20190126063038.GG4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901260120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:55:46AM +0900, SeongJae Park wrote:
> This patchset updates the Korean translation of memory-barriers.txt to follow
> latest changes.  It has been reviewed by my one Korean colleague.
> 
> SeongJae Park (2):
>   sched/Documentation/kokr: Update Korean translation to update
>     wake_up() & co. memory-barrier guarantees
>   locking/memory-barriers/kokr: Update Korean translation to replace
>     smp_cond_acquire() with smp_cond_load_acquire()
> 
>  .../translations/ko_KR/memory-barriers.txt         | 49 ++++++++++++----------
>  1 file changed, 28 insertions(+), 21 deletions(-)

Queued on the strength of the Reviewed-bys.

							Thanx, Paul

