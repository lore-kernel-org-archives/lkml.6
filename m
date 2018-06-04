Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1381134-1528086460-2-9316361804781185299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528086460; b=Ha0zhwa15QRUJIzphCQIso7oPidnE8LyNbskvBtNV+HHwyScWQ
    6tk6NrZBmS1gDO2dc7HoKfwr0XgraCyfiFgMaG9u3BOIR8cdshjlwuhyFX7L0ZTN
    uQjxuUS7qWl88aqghLLoX94++x0WszRQdKFc9MuvGBan1OzoIpBn+CglSvfnqr4z
    Ika74GwREd0b05Kbuc87OawOLKHLP7AwXVEje4zKtHjILDeIeGROt0Ek3efZE2Eq
    bXN9Kk0lZJQNRhqgHcyxT3hNZfa/CIwHgZ16GCwHvZwfu+FgSCDnXV8OvcrT3SWN
    WpMJjXyTqiyHD55N4od9YpLceroXshAb5a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1528086460; bh=prvzgbE43c
    bPxQHGkO9M3icxUKw/Au8CQ5dZ0Xd1KCA=; b=Q2vx26wlwUQuDqbLXS1ygm+k1f
    5bxHLXo9wQNwvgy5Cskub1vbO9DeEJZUsit5+/VsW6Tl/ByuwQTn+pPxDj7r2mmO
    cjU/osvJR6FqjUy6Wj9fHhrhPRKkGQ28E9Hb4hsaAKeL59G6fVplpDxrjiXhZtY+
    mxBdxgN7tK5J83dgY/CWTuVlwFAtwxUjpgd51nghuZUQNonupND1uRkBZWrRF6hL
    5C2KveWst0K+DNk++8uiqgQ2hJSpdrqFMviN4wEaQoASS5okXYfkOE7Lv0YoKjCS
    hJTWRJGFy5qlUccRaSOEesPpt+3nv6FfKg/2fbXojFaxjDZQZuV2Cx1vO70g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4CebMvJ2blJyD8TG8RapwrSY6Lf5ohf/gVUiXK/pfhWYi6J2cuVeZrN8cX296efchxsd2S2kPwfYhuiRbc04FF748bhplXvTWEmvxmtSwqfKNquLAG
    ao3hl+3yOEqmkfXuTPPvMO2KlMLY8zBmvDPqoqpvvp9nXTfxdqpIEpm7qbHf2FP5FZbJW18WokbAai35JLpk/7EeLbrQkkozoCfKsNUQBbEK7OyLUxAYbf33
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EbVHfS3oRaoA:10 a=IkcTkHD0fZMA:10
    a=7mUfYlMuFuIA:10 a=i3X5FwGiAAAA:8 a=VwQbUJbxAAAA:8 a=6NuTs-VdzuYA-gG_B68A:9
    a=QEXdDO2ut3YA:10 a=ic4oXV6auKO-Q6VfiSZ6:22 a=mmqRlSCDY2ywfjPLJ4af:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbeFDE1i (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 00:27:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:57013 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbeFDE1h (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 4 Jun 2018 00:27:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,475,1520924400";
   d="scan'208";a="64043693"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Naresh Bhat <naresh.bhat@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>
Subject: RE: [PATCH V5 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Topic: [PATCH V5 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Index: AQHT9vOycW5QHpsqGkehQKqjrruTMqRMstgAgALXhEA=
Date: Mon, 4 Jun 2018 04:27:34 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F3B6EABDF@ORSMSX114.amr.corp.intel.com>
References: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAFoFrHYcD7fGYaJzKwcPCtu+XyR+mh5ORDqmCpiBjLmEkDfwOQ@mail.gmail.com>
In-Reply-To: <CAFoFrHYcD7fGYaJzKwcPCtu+XyR+mh5ORDqmCpiBjLmEkDfwOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGUyZmM2ZDQtMThiYy00ZmM2LTljOGMtOTg0ZDg5ZGUxZGE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidU5UXC9NOEJmbWxUN2krUTlmXC9YV1V2Qk5ORUdHNys0MGpCZ21zMkdYanhYeTkxc3hUNGt6VTZHeUM1TmE2NE5mIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiA+IFRlc3Rpbmc6DQo+ID4gLS0tLS0tLS0NCj4gPiBUZXN0ZWQgdXNpbmcgTFVWIChMaW51eCBV
RUZJIFZhbGlkYXRpb24pIGZvciB4ODZfNjQsIHg4Nl8zMiBhbmQgYXJtNjQNCj4gPiAocWVtdSBv
bmx5KS4gV2lsbCBhcHByZWNpYXRlIHRoZSBlZmZvcnQgaWYgc29tZW9uZSBjb3VsZCB0ZXN0IHRo
ZQ0KPiA+IHBhdGNoZXMgb24gcmVhbCBBUk0vQVJNNjQgbWFjaGluZXMuDQo+ID4gTFVWOiBodHRw
czovLzAxLm9yZy9saW51eC11ZWZpLXZhbGlkYXRpb24NCj4gDQo+IEkgaGF2ZSB0ZXN0ZWQgVjQg
c2VyaWVzIG9uIFRodW5kZXJYMiBWYWwxIGFuZCBTYWJlciBwbGF0Zm9ybSBieSBpbnRlZ3JhdGlu
ZyB0aGUNCj4gcGF0Y2hlcyB3aXRoIExVViBwcm9qZWN0Lg0KPiBJIHdpbGwgdGVzdCBWNSB2ZXJz
aW9uIHNvb24gYW5kIGxldCB5b3Uga25vdyB0aGUgb3V0Y29tZS4NCg0KVGhhbmtzIGEgbG90ISBm
b3IgdGFraW5nIHRpbWUgdG8gdGVzdCB0aGUgcGF0Y2ggc2V0LCBOYXJlc2guIFdpbGwgYmUgd2Fp
dGluZyB0byBzZWUgdGhlIHJlc3VsdC4NCg0KUmVnYXJkcywNClNhaQ0K
