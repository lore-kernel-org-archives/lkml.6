Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeBBOt4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:49:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751887AbeBBOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:49:48 -0500
Subject: Re: [GIT PULL] IMA bug fixes for 4.16
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 02 Feb 2018 09:49:39 -0500
In-Reply-To: <alpine.LRH.2.21.1802022106130.2739@namei.org>
References: <1517510282.6675.13.camel@linux.vnet.ibm.com>
         <alpine.LRH.2.21.1802022106130.2739@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020214-0040-0000-0000-0000040BC90A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020214-0041-0000-0000-0000260F6D7F
Message-Id: <1517582979.3171.46.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 21:07 +1100, James Morris wrote:
> On Thu, 1 Feb 2018, Mimi Zohar wrote:
> 
> > Hi James,
> > 
> > Included in this pull request are three bug fixes, assuming the 2 FUSE
> > patches are considered bugs and not new features, and a maintainer update.
> > I'd appreciate your sending them to Linus for 4.16.
> 
> I'd like to see an acked-by or reviewed-by from the FUSE maintainer 
> (cc'd), on the FUSE patches.

Ok.  For now, can you take the first two patches?

Mimi
