Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeBSXxP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:53:15 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:56916 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932245AbeBSXxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:53:13 -0500
X-Google-Smtp-Source: AH8x226Z6LZIhk4ktHLsqEMxQdx/EmUW0Y51fU1JH5GXIAHWciEZO4PqbXCLsvI0jN/Y7GmlcmSlxw==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Cc: Jon Masters <jcm@jonmasters.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future CPUs
In-Reply-To: <0575AF4FD06DD142AD198903C74E1CC87A61923C@ORSMSX103.amr.corp.intel.com>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk> <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk> <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com> <1518509708.12890.33.camel@infradead.org> <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com> <1518517262.12890.43.camel@infradead.org> <1518518198.12890.48.camel@infradead.org> <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com> <1518775136.7876.13.camel@infradead.org> <75287047-77a0-e0ff-c2e8-61c81641251e@redhat.com> <1518776517.7876.21.camel@infradead.org> <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com> <1518783021.7876.34.camel@infradead.org> <4882860e-23c5-75b3-ac02-c700f615156e@jonmasters.org>
 <0575AF4FD06DD142AD198903C74E1CC87A61923C@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1519084385_3347P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Feb 2018 18:53:05 -0500
Message-ID: <10373.1519084385@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1519084385_3347P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 Feb 2018 23:42:24 +0000, "Van De Ven, Arjan" said:

> the guest is not the problem; guests obviously will already honor if Enhanced
> IBRS is enumerated. The problem is mixed migration pools where the hypervisor
> may need to decide to not pass this enumeration through to the guest.

For bonus points:  What should happen to a VM that is live migrated from one
hypervisor to another, and the hypervisors have different IBRS support?

--==_Exmh_1519084385_3347P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWotjYY0DS38y7CIcAQKk7wf7BvI+Z/7zK+ZZpj4lSNIdrdUjyEg7mn0R
Vew6NFaLpP/G4ZeJEd70wG/D29GtKWlNKWbgV7nhNusSHxZVddaOx3elXtWHXSW9
2zJveZ5FVzfan/FwGVITg8egtvnyazKBTmrBOEBQFyvgdbSgnLqbKu0kcKet8Yaf
GBQVd1DvISfLWtEAA1kPj4EDMz5Nhsspr75o9zSH4lelp+OkYHASUvYHlSMpWEK5
SBachW8j1t/gsoIaZ+7aqNLt5Xe+C3fPcajQtf55l0IV/j6V1+ziCcGMTouNs3en
3sK8MmeWOCYVaf43T7YbWSH7lBnS5oaKVzZwtK+UYs8Kqe4yhc6z6w==
=bDvg
-----END PGP SIGNATURE-----

--==_Exmh_1519084385_3347P--
