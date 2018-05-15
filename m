Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeEOQHc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:07:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41502 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeEOQHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:07:30 -0400
Date: Tue, 15 May 2018 12:06:58 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Raslan, KarimAllah" <karahmed@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping interface
Message-ID: <20180515160658.GA12122@char.us.oracle.com>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
 <b390f953-6fe3-1119-15eb-e3b31e609305@redhat.com>
 <1523880592.22952.9.camel@amazon.de>
 <34b4c91d-46f0-1205-5850-f13ccb70d496@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <34b4c91d-46f0-1205-5850-f13ccb70d496@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FG7aIx000513

On Mon, Apr 16, 2018 at 02:27:13PM +0200, Paolo Bonzini wrote:
> On 16/04/2018 14:09, Raslan, KarimAllah wrote:
> >> I assume the caching will also be a separate patch.
> > Yup, do you want me to include it in this one? I already have it, I
> > just thought that I get those bits out first.
> 
> It's the same for me.
> 
> Paolo
> 
> >> It looks good except that I'd squash patches 4 and 9 together.
> > Yup, makes sense. I should have squashed them when I removed the 
> > lifecycle change!
> > 
> > Thanks for the review :)
> > 
> >> But I'd like a second set of eyes to look at it.

Did anybody else end up reviewing these patches? And would it make sense
to repost a new version with the #4 and #9 squashed? Thanks.

> 
