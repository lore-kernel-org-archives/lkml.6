Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeCMWvy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:51:54 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:30713
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751300AbeCMWvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:51:52 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/7] x86/hyper-v: move definitions from TLFS to
 hyperv-tlfs.h
Thread-Topic: [PATCH v3 2/7] x86/hyper-v: move definitions from TLFS to
 hyperv-tlfs.h
Thread-Index: AQHTt69iBSfnM3DPDkaCDdVEVhIZRqPOy9gw
Date: Tue, 13 Mar 2018 22:51:49 +0000
Message-ID: <DM5PR2101MB10309D732885B77D4B9E2F5FDCD20@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-3-vkuznets@redhat.com>
In-Reply-To: <20180309140249.2840-3-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-13T22:51:47.7051048Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:WgfZ40uxBqZTcyf/Y60255X0BI98sOR11muEVgxD8DiVxMyilD53paMGLrm1q9AF/6dwy9MY5YozJl5XKV5IBBvEvP1nfEM44GZgPsqoF+Hhgw4Yo9Xq4YtHJiEKR6v+u71rdPHH3K5pgEF5yj5bis28was+wuMzlfv2/h6r1qSSg+SPiux021A8JqJVdbiJaryqn937Ocejc1/x820fuiuxPq6wf1vNVlLu3CYs5ijD0iwOgF0Odv1gf91z7qTH;20:mh0kxh4KDmQrcjDp7WFwggD+Jdtjtr4/4BU+QJ7ygME1FBIvJhhy1SWvoNayB0OnyMhnpsiMrypeVfG5IjkYjMPzt760IPSFs5CTG+fzVIMd56niva/iJ/XDj46O1LJQ6EbutWWu5rZCvipSrUDdg8r9rtdlsRcEac/HFVERrc8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f15d194-c7b3-4ed1-7f3b-08d5893501d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
x-microsoft-antispam-prvs: <DM5PR2101MB09660AB5BB0554995D599323DCD20@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501255)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(39860400002)(346002)(366004)(199004)(189003)(13464003)(33656002)(8990500004)(106356001)(105586002)(81156014)(10090500001)(478600001)(53936002)(86362001)(25786009)(4326008)(6246003)(10290500003)(5660300001)(2906002)(6436002)(68736007)(97736004)(3280700002)(22452003)(229853002)(54906003)(86612001)(316002)(305945005)(7736002)(8936002)(5250100002)(110136005)(3660700001)(102836004)(9686003)(2501003)(2950100002)(72206003)(14454004)(2900100001)(8676002)(186003)(7696005)(81166006)(26005)(53546011)(99286004)(76176011)(55016002)(6116002)(74316002)(66066001)(3846002)(6346003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: +/woSZ5BpkDJQdKYAd/56+8BTniQGzNb9J+dIwAemetBL/VzFJ/9mhlYOopCqrM2VjxOyK3Lb8zZSpnQwdGJupryhRbU/VC22yCt8sMxq193ZgpqgqX5Xswd69t4Pn+38bBFEnuLKkvxl8QySkYATce1nf4P1aebqQj6iio7ZkdX1G1UTAluzW+Jqe9mlCYPmE0G4j9TxNhe7O+Hak137HcAnodcBXd67MacSH13mh5F64EtYN0VkklDqbezDZ7/+8yc/h03MHeSkF2fJY7JkuqRkQdT42krDjhVi9YvCKwnagunfFzx/yUyS4ND8TB68iapSGVl4fVaV7LfMkkEpQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f15d194-c7b3-4ed1-7f3b-08d5893501d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 22:51:49.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2DMpxw3005822

> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, March 9, 2018 6:03 AM
> To: kvm@vger.kernel.org
> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim Krèmáø
> <rkrcmar@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; Bandan Das <bsd@redhat.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3 2/7] x86/hyper-v: move definitions from TLFS to hyperv-tlfs.h
> 
> mshyperv.h now only contains fucntions/variables we define in kernel, all
> definitions from TLFS should go to hyperv-tlfs.h.
> 
> 'enum hv_cpuid_function' is removed as we already have this info in
> hyperv-tlfs.h, code in mshyperv.c is adjusted accordingly.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
