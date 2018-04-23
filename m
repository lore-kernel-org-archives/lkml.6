Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbeDWWPV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:15:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932514AbeDWWPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:15:20 -0400
Date: Mon, 23 Apr 2018 15:16:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180424074844.36464221@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424074844.36464221@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042322-0008-0000-0000-000002FCE4B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008908; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022281; UDB=6.00521769; IPR=6.00801516;
 MB=3.00020734; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 22:15:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042322-0009-0000-0000-00003901AA1B
Message-Id: <20180423221628.GS26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 07:48:44AM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> Commit
> 
>   bbf9d3657c39 ("doc: Ensure whatisRCU.txt actually says what RCU is")
> 
> is missing a Signed-off-by from its committer.

Good catch, fixed!

							Thanx, Paul
