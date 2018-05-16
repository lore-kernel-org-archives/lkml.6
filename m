Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZo2eZjyD7gMSO9x4Ux4tUNq1AxPtvSwpj21pd1qapczH5/MLfa8gb8Q9q7+gEEQD/OSu3DD
ARC-Seal: i=1; a=rsa-sha256; t=1526463782; cv=none;
        d=google.com; s=arc-20160816;
        b=Npr0eU4Ir/0fJ2IEnny13fqPWmbZISkmPEQLVK5X8K6AQP7p7fQbBRRohUxeWuZygE
         WaEzegpoG/+6VmccXYnoOd2koSNS4VqRQTLDlwefSUs22oSoo8GW4DYX74MAP7UbCP7J
         2RnU6kQJrKGKa9ewmr6bJBKWASWLPxyWmXP3AQGBVfyZzEANpvWZs18nfFCVRcruteGE
         XrP11OhwXUs7WpOa5XfwMc0uFCZO7Z7NN3OO9BMkp9mvAUY5LAhYQZ1yJJ6QvPUYqMnn
         MWXENaQeTG82DR7jJT57Rf3bvoaUnjhN1y82jScliGKj9tkcL+BgxatXeEdd4kuooik6
         0EVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=HtEHNIifNNZ1uPULe5fgrbUzt9b42fxl29pRB9dmrcc=;
        b=LOd0N85t1IZyCnST8igSd/3SaVUzQG4ztVPVoenu1lJB4C9znaJtj/xhF75pYBqCfZ
         VpCh5XtagZp/1+eHYM4XVrQZjLQgSxuQw6cnwKC7RUYPeuk40Zzav79RCO7syltjW91n
         mh4GAbd8S2KMjtoWHWVg2aIwhvoIcBSIKXQtgM2nxdiIuFgmtjsDdhUidlro+SdBrdhu
         ZYvVBSqjeOBm7LixaGXrFrJdiKC5bZb9jl6r1wzE+wFa1QBFg7DMRktZcfpv2pIY2Dxb
         GJC0ZOLpSeivZHm3imc62bpaH8GdwDQo8Yla80gE63107UHyEpeBild/O1TreFaBUUZ1
         xaag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=luwei.kang@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=luwei.kang@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="39746658"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bp@suse.de"
	<bp@suse.de>, "Liang, Kan" <kan.liang@intel.com>,
	"Janakarajan.Natarajan@amd.com" <Janakarajan.Natarajan@amd.com>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mathieu.poirier@linaro.org"
	<mathieu.poirier@linaro.org>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rkrcmar@redhat.com" <rkrcmar@redhat.com>, "david@redhat.com"
	<david@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
	"yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>
Subject: RE: [PATCH v8 01/12] perf/x86/intel/pt: Move Intel-PT MSRs bit
 definitions to a public header
Thread-Topic: [PATCH v8 01/12] perf/x86/intel/pt: Move Intel-PT MSRs bit
 definitions to a public header
Thread-Index: AQHT62JliC5AtH9UP0+sBA4842ekgqQuffyAgAOeMWA=
Date: Wed, 16 May 2018 09:42:58 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167F7B1B8@SHSMSX101.ccr.corp.intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
 <1526295432-20640-2-git-send-email-luwei.kang@intel.com>
 <20180514102217.uc3kzhu6gs4wapuo@um.fi.intel.com>
In-Reply-To: <20180514102217.uc3kzhu6gs4wapuo@um.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWRiZDRmOWItMjlkMS00MThmLWEwMGUtNWY5NTBhMTQxODRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJNcUY2V09uXC9IQVNaYnBwa3dlT1ZESUU2d1wvWGY1U04wK0NTT3lwOGJaZ2VGM3F1VTd3NjhIYVFmOFNoSWRxV0IifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429565340015294?=
X-GMAIL-MSGID: =?utf-8?q?1600613287117968559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> > Intel Processor Trace virtualization enabling in KVM guest need to
> > access these MSRs bit definitions, so move them to public header file
> > msr-index.h.
> > @@ -115,6 +148,7 @@
> >  #define MSR_IA32_RTIT_ADDR2_B		0x00000585
> >  #define MSR_IA32_RTIT_ADDR3_A		0x00000586
> >  #define MSR_IA32_RTIT_ADDR3_B		0x00000587
> > +#define MSR_IA32_RTIT_ADDR_RANGE	4
>=20
> This one wasn't there before, so belongs in a different patch.

What about move this definition to "arch/x86/include/asm/intel_pt.h " and b=
e added in patch 8 (implementation of context switch).

Thanks,
Luwei Kang

>=20
> Regards,
> --
> Alex
