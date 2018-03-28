Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeC1VMl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:12:41 -0400
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:46256
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753068AbeC1VMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:12:39 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
To: =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] KVM: VMX: Bring the common code to header file
Thread-Topic: [PATCH v2 3/5] KVM: VMX: Bring the common code to header file
Thread-Index: AQHTvWbQNuxdQSk8B0ynPvZatwcbCaPmK1uAgAAMloA=
Date: Wed, 28 Mar 2018 21:12:35 +0000
Message-ID: <CY4PR12MB1768042143F29091B60BF62195A30@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
 <1521232646-79580-4-git-send-email-babu.moger@amd.com>
 <20180328202640.GJ26753@flask>
In-Reply-To: <20180328202640.GJ26753@flask>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1926;7:x16xhhdRCF6CCXSXLoJas08UtcwWSPB2bBjLJ7aXX61rNC9tvURoTTfDjFAXz+Vo93F1MWgwp93yYAea0qihUhyts5GpPsEn7dAPUsI4wZQNTmbmlmMKROI0zAn15lnG0yvUeeQrfVFNfzFALqc6b+FIJyMMBRXTH54rABjHtXLMNem2YQUfJUDhARsv6LcgWuLzN7ewYwveK7X/TU4jqj25Ee00ktV9zSOTko7MpnbXuR2/A5VV0cWGRh62Uh2E;20:yCYetWucfk2yp1UibGMPQmiMzDB0Vd9qI1P5JnV2UIYphl8ktosV+kMUzsRzxGaivlr6VxdmmNW7TsshC05GaMPVscNBWzoalq/NhVDrKSftPBM0wAnHjdLQJnFjeC33Jz2qHa51ytQB9ybTDunmcDftdnAHtku9Hz7wAkmo93NkFn2NO64ZkIdLkGLCoXMHy9UqHWm3wPSYNDVrMx70+mNzgtBPGQXoO/liwVVHhXt6orGb/kOCkNIBDBvtjlTr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28cf8c2f-22f5-4691-6325-08d594f0a138
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1926;
x-ms-traffictypediagnostic: CY4PR12MB1926:
x-microsoft-antispam-prvs: <CY4PR12MB1926F546159DBE3AD7E40B9395A30@CY4PR12MB1926.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1926;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1926;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39380400002)(39860400002)(13464003)(189003)(199004)(377424004)(4326008)(5660300001)(99286004)(316002)(2900100001)(54906003)(7736002)(478600001)(6916009)(33656002)(229853002)(305945005)(6246003)(25786009)(74316002)(53546011)(6506007)(66066001)(5250100002)(53936002)(76176011)(486005)(476003)(11346002)(26005)(486005)(105586002)(81156014)(102836004)(186003)(446003)(72206003)(2906002)(14454004)(68736007)(3660700001)(3280700002)(6116002)(7696005)(3846002)(8676002)(6436002)(81166006)(86362001)(8936002)(55016002)(9686003)(106356001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1926;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SMdfBLX2ieivrsTBLZA8CJI94vMmnXPy+LxyTHMogUhzYsP6WBT/unec2+8X3bLdEzxmf/4+b0IZ2vshNTzVFk0sa1pwlx4+P+tDAJhLRfxO/OKdSbfSlxnFm7Nz30j5gcvJCDy2YZyB4fThg8WsN8nq0Bm0tkzNJOyf43tNbb6zCARTbYArIt6MFpOS+IJJYWZKWvKWaBjuZ/+NFJ+WPrg7AT7/olYxSBCjHPC2M4BOuJOMh8v4zlk9GACpnHc2HV0iQPUWy+wr7AOtkULwKceFGOFHXlsYbvUdxtwfnnsgTDEvmRKaFVVBk7ZtShXX9SFYsFb4b55q/gWN0xDcqQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cf8c2f-22f5-4691-6325-08d594f0a138
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 21:12:36.0213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SLCkQ6005931


> -----Original Message-----
> From: Radim Krèmáø <rkrcmar@redhat.com>
> Sent: Wednesday, March 28, 2018 3:27 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: joro@8bytes.org; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; pbonzini@redhat.com;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 3/5] KVM: VMX: Bring the common code to header
> file
> 
> 2018-03-16 16:37-0400, Babu Moger:
> > This patch brings some of the code from vmx to x86.h header file. Now, we
> > can share this code between vmx and svm. Modified couple functions to
> make
> > it common.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > @@ -6683,8 +6652,9 @@ static void shrink_ple_window(struct kvm_vcpu
> *vcpu)
> >  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> >  	int old = vmx->ple_window;
> >
> > -	vmx->ple_window = __shrink_ple_window(old,
> > -	                                      ple_window_shrink, ple_window);
> > +	vmx->ple_window = __shrink_ple_window(old, ple_window,
> > +					      ple_window_shrink,
> > +					      0);
> 
> I have preserved the old minumum (ple_window, so we could't get
> uselessly small values).

Ok. Looks good. Thanks
