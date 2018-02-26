Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeBZXV5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:21:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751465AbeBZXVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:21:55 -0500
Date: Mon, 26 Feb 2018 15:22:19 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180227093816.29519e8e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227093816.29519e8e@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022623-0008-0000-0000-000002DBA4EC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995559; UDB=6.00506051; IPR=6.00774888;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 23:21:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022623-0009-0000-0000-000038651070
Message-Id: <20180226232219.GV2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260292
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:38:16AM +1100, Stephen Rothwell wrote:
> Hi Paul,
> 
> Commit
> 
>   2a84d1aef423 ("rcu: Inline rcu_preempt_do_callback() into its sole caller")
> 
> is missing a Signed-off-by from its committer.

That would be because idiot here left the "-s" off of "git am"...

Apologies for the hassle, rebased to fix.

							Thanx, Paul
