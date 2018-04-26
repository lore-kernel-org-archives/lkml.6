Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeDZBOz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:14:55 -0400
Received: from mail-sn1nam02on0132.outbound.protection.outlook.com ([104.47.36.132]:12096
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751212AbeDZBOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:14:53 -0400
From: Long Li <longli@microsoft.com>
To: Greg Thelen <gthelen@google.com>, Steve French <sfrench@samba.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: Christoph Hellwig <hch@lst.de>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Tarick Bedeir <tarick@google.com>
Subject: RE: [PATCH 4/5] cifs: smbd: depend on INFINIBAND_ADDR_TRANS
Thread-Topic: [PATCH 4/5] cifs: smbd: depend on INFINIBAND_ADDR_TRANS
Thread-Index: AQHT3OWSsJs0EUVbdUCIIcLt5VET6KQSPf+Q
Date: Thu, 26 Apr 2018 01:14:49 +0000
Message-ID: <MWHPR2101MB07293DD81DF86317C2A6917ECE8E0@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180425223412.207127-1-gthelen@google.com>
In-Reply-To: <20180425223412.207127-1-gthelen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:5::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0809;7:mWhoLoB4ycwFUZ5/tL9U9G/JSqwI4FHx7OAYzUO4RL51+Yz5WTBeiJrH9pkiaF6YjrL5YuW7CzDu2PWGSf0eeRjE2cWrf9cucTOixvCraFC5oVE5pXvgLxkzoBF9qDBJ8K3xbSEoVp7kI25zv75HxmBnWpJ/NmZdJN3azRTR4rB7XiMHrBndhAIaa6ez7sRy2qoqlSIdYT3jDj010bdi2w8NriHdQ2YPx0YfzX8JWSrpgdrS8P4wykCVIch3bthz;20:y4MUTnPYWId+ceqgr4k2lLMz3QyR8KsxN/cmrkICeqT4kEFeUEcBiFKLT0uYsGY5hEAHhf26n0geCauAhz9+jPXPbgpmiaUsF3BGSTvd6OpoLbjxWHBFwlIUaaqbYlfGzmD6JEvW4QFbihynayeIu1xokM+LpN+UHiBSH/cD99U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR2101MB0809;
x-ms-traffictypediagnostic: MWHPR2101MB0809:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB080960A52F6871B7FE336C31CE8E0@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(211936372134217)(153496737603132)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR2101MB0809;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0809;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(346002)(376002)(189003)(199004)(4326008)(5250100002)(11346002)(6246003)(486006)(446003)(6306002)(33656002)(476003)(53936002)(55016002)(9686003)(2900100001)(10090500001)(8990500004)(106356001)(105586002)(54906003)(110136005)(46003)(316002)(22452003)(14454004)(966005)(8676002)(229853002)(3280700002)(3660700001)(2906002)(7736002)(305945005)(10290500003)(478600001)(6116002)(6436002)(68736007)(81156014)(81166006)(25786009)(8936002)(76176011)(7416002)(59450400001)(7696005)(74316002)(186003)(86362001)(102836004)(6506007)(86612001)(99286004)(97736004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0809;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6uHcOZSY5WeaWsT1ugJyKqkI96KX+FfLasr7xI3klVkT58D+xfGqng+vD0RRIEIQSgLls5sCbJ0c6BttFXTR2P3uPQ1Ex7VlqCSYbd7548E0CZq2hDxeY/+Hmv7g1DLkRsdNNiTjO5VZgkBYzniR3jDHplyV2W1o25k+iHwrtMg8d4d3C81PlaFrcow6FhtE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1fce7cae-0334-4237-0502-08d5ab131b85
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fce7cae-0334-4237-0502-08d5ab131b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 01:14:49.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3Q1F1ZV013015

> Subject: [PATCH 4/5] cifs: smbd: depend on INFINIBAND_ADDR_TRANS
> 
> CIFS_SMB_DIRECT code depends on INFINIBAND_ADDR_TRANS provided
> symbols.
> So declare the kconfig dependency.  This is necessary to allow for enabling
> INFINIBAND without INFINIBAND_ADDR_TRANS.
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Cc: Tarick Bedeir <tarick@google.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  fs/cifs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig index
> 741749a98614..5f132d59dfc2 100644
> --- a/fs/cifs/Kconfig
> +++ b/fs/cifs/Kconfig
> @@ -197,7 +197,7 @@ config CIFS_SMB311
> 
>  config CIFS_SMB_DIRECT
>  	bool "SMB Direct support (Experimental)"
> -	depends on CIFS=m && INFINIBAND || CIFS=y && INFINIBAND=y
> +	depends on CIFS=m && INFINIBAND && INFINIBAND_ADDR_TRANS
> || CIFS=y &&
> +INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
>  	help
>  	  Enables SMB Direct experimental support for SMB 3.0, 3.02 and 3.1.1.
>  	  SMB Direct allows transferring SMB packets over RDMA. If unsure,
> --
> 2.17.0.441.gb46fe60e1d-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.ke
> rnel.org%2Fmajordomo-
> info.html&data=02%7C01%7Clongli%40microsoft.com%7C680883705136432b
> 280b08d5aafcb355%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63
> 6602924686676279&sdata=cn1DPTCOpL2%2BBa62wGlUp2dEe8BAzFVPxhfRxf
> 2N1Ek%3D&reserved=0
