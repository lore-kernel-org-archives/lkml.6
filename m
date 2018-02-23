Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeBWXpb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 18:45:31 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:39159 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeBWXp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 18:45:28 -0500
X-IronPort-AV: E=Sophos;i="5.47,385,1515456000";
   d="scan'208";a="721333113"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH 05/10] KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR
 bitmap
Thread-Topic: [PATCH 05/10] KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR
 bitmap
Thread-Index: AQHTqzwS35Ec9zKl6kusy6yAxmwWsqOyhiIAgAAkHQA=
Date: Fri, 23 Feb 2018 23:45:18 +0000
Message-ID: <1519429518.13144.16.camel@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
         <1519235241-6500-6-git-send-email-karahmed@amazon.de>
         <20180223213602.GG20992@char.us.oracle.com>
In-Reply-To: <20180223213602.GG20992@char.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.199]
Content-Type: text/plain; charset="utf-8"
Content-ID: <29A4FF11EAF21143B67D091E370EBF65@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1NNja97006497

On Fri, 2018-02-23 at 16:36 -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Feb 21, 2018 at 06:47:16PM +0100, KarimAllah Ahmed wrote:
> > 
> > ... since using kvm_vcpu_gpa_to_page() and kmap() will only work for guest
> > memory that has a "struct page".
> > 
> > The life-cycle of the mapping also changes to avoid doing map and unmap on
> 
> s/also changes/has been changed/ ?

Right, will fix in v2.

Thanks.
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
