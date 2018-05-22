Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEVPnT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:43:19 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:48282 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeEVPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:43:15 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520899200";
   d="scan'208";a="742232744"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping interface
Thread-Topic: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping
 interface
Thread-Index: AQHT1QRgTdVQE1Wqo0a2IXn3xPxQ2KQDPR4AgAAQfwCAAATZgIAt0QEAgAr5rgA=
Date: Tue, 22 May 2018 15:43:12 +0000
Message-ID: <1527003792.13207.56.camel@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
         <b390f953-6fe3-1119-15eb-e3b31e609305@redhat.com>
         <1523880592.22952.9.camel@amazon.de>
         <34b4c91d-46f0-1205-5850-f13ccb70d496@redhat.com>
         <20180515160658.GA12122@char.us.oracle.com>
In-Reply-To: <20180515160658.GA12122@char.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C95F199AACBD84AAD8F3EFC9ED330AF@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4MFhNHi011986

On Tue, 2018-05-15 at 12:06 -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Apr 16, 2018 at 02:27:13PM +0200, Paolo Bonzini wrote:
> > 
> > On 16/04/2018 14:09, Raslan, KarimAllah wrote:
> > > 
> > > > 
> > > > I assume the caching will also be a separate patch.
> > > Yup, do you want me to include it in this one? I already have it, I
> > > just thought that I get those bits out first.
> > 
> > It's the same for me.
> > 
> > Paolo
> > 
> > > 
> > > > 
> > > > It looks good except that I'd squash patches 4 and 9 together.
> > > Yup, makes sense. I should have squashed them when I removed the 
> > > lifecycle change!
> > > 
> > > Thanks for the review :)
> > > 
> > > > 
> > > > But I'd like a second set of eyes to look at it.
> 
> Did anybody else end up reviewing these patches? And would it make sense
> to repost a new version with the #4 and #9 squashed? Thanks.

No, no second review yet. I will squash and repost a new version.

> 
> > 
> > 
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
