Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeELCxM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 22:53:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750793AbeELCxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 22:53:11 -0400
Date: Fri, 11 May 2018 19:54:36 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: trace: Remove Startedleaf from trace events comment
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180512012900.GA183767@joelaf.mtv.corp.google.com>
 <CAEXW_YSmadNG1AbdSa=ujofbZ1oQLrthWdeB+_HNMOFZQzGaxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSmadNG1AbdSa=ujofbZ1oQLrthWdeB+_HNMOFZQzGaxA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051202-0052-0000-0000-000002ED5160
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009009; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01031010; UDB=6.00526960; IPR=6.00810141;
 MB=3.00021060; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-12 02:53:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051202-0053-0000-0000-00005CA71851
Message-Id: <20180512025436.GD26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805120022
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 06:29:57PM -0700, Joel Fernandes wrote:
> On Fri, May 11, 2018 at 6:29 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > As part of the gp_seq clean up, the Startleaf condition doesn't occur
> > anymore. Remove it from the comment in the trace event file.
> 
> Sorry, I meant here Startedleaf. Let me know if you want me to resend the patch.

Please do, as it saves me making another typo when attempting to fix it.

							Thanx, Paul
