Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeDDRLD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:11:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54374 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeDDRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:11:01 -0400
Date: Wed, 4 Apr 2018 13:10:40 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Fritsch <sf@sfritsch.de>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: Add emulation for movups/movupd
Message-ID: <20180404171040.GW5438@char.us.oracle.com>
References: <20180401155444.7006-1-sf@sfritsch.de>
 <fbc6c706-e9ec-7d90-b8b4-858413cf922e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc6c706-e9ec-7d90-b8b4-858413cf922e@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 05:53:04PM +0200, Paolo Bonzini wrote:
> On 01/04/2018 17:54, Stefan Fritsch wrote:
> > This is very similar to the aligned versions movaps/movapd.
..snip..
> Applied, thanks.

Should there be a corresponding test-case?
> 
> Paolo
