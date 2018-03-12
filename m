Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCLXG1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:06:27 -0400
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:13280
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751359AbeCLXG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:06:26 -0400
From: "Li, Roman" <Roman.Li@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        David Binderman <dcb314@hotmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE:
 linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]:
 (warning) Possible null pointer dereference: pipe_ctx
Thread-Topic: linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]:
 (warning) Possible null pointer dereference: pipe_ctx
Thread-Index: AQHTulDAsC1cVPdHK0eKq9+HqhKd/qPNNUmg
Date: Mon, 12 Mar 2018 23:06:23 +0000
Message-ID: <DM5PR12MB1211B9CFBCC532003F5FEDAA89D30@DM5PR12MB1211.namprd12.prod.outlook.com>
References: <HE1PR0802MB2331D43DAFA4EDDE964F0CC69CD30@HE1PR0802MB2331.eurprd08.prod.outlook.com>
 <8b55ac58-ae20-7662-10bb-c446701cd67e@amd.com>
In-Reply-To: <8b55ac58-ae20-7662-10bb-c446701cd67e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Roman.Li@amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1786;20:YCepAxvsXCoVAT7O821oPxtwQR77fyDcQebyvrS7nQGx7merhYR4+I5Qqr7RbXGNuXRMcqsn5wDoSyYRV3dAFwDWV884KPy2Uu3S9+CDblaIPPjR0DCDVcXymEvCCTHeDp/D5d0YqDLkA8ssST7ObrTFi3H8S5/XAC9lPcToM8XhOfepiNmoq2fWA8m22mzYTDrfeIDFTXm84EnhOQGqcn7QMQnnDvLuFH6O6fFoVJI6y5oNC+JgBhqG+bfQG+jp
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(13464003)(199004)(189003)(7696005)(2950100002)(74316002)(99286004)(2201001)(7736002)(8676002)(81156014)(316002)(26005)(305945005)(76176011)(81166006)(229853002)(15760500003)(6636002)(39060400002)(6436002)(6246003)(102836004)(9686003)(55016002)(3280700002)(6306002)(86362001)(8936002)(53936002)(53546011)(6506007)(5660300001)(59450400001)(2906002)(97736004)(966005)(72206003)(25786009)(3846002)(105586002)(110136005)(2900100001)(33656002)(3660700001)(2501003)(6116002)(5250100002)(478600001)(68736007)(106356001)(14454004)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1786;H:DM5PR12MB1211.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9a245da-6914-44ee-a267-08d5886de008
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1786;
x-ms-traffictypediagnostic: DM5PR12MB1786:
x-microsoft-antispam-prvs: <DM5PR12MB1786675975244C9125A8EB6D89D30@DM5PR12MB1786.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1786;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1786;
x-forefront-prvs: 06098A2863
x-microsoft-antispam-message-info: kokguqgzOli3mj907zBTGG3v3XRPj5zUh6RespBbyMZ3UVSJZxbvNLmI3eOhFJUDpyZ7leUVQyByD0+qWgvpiNCksrTECCpVMBDA0Dz0X0VpLsxLYeVb0ArI/vxQAVlRh6jsTBFnBUYdALlR3YvaJtZMZ3nZkejpSanmSR6yHm4uzDKBfuhVNo877UhHnutK8iIIWAK55/zkvt9q8NNwvtATWddY6TuBB/XEUGAHSEAWBtLEkEOe89a1Kfarc0yvvvt5pLPYrIz2Noe3sCwfb7Rjf3qYKAQoagLDXFIIeNeoV9wpNE9A7Qaoo9V4A91QlrrF25T+Pp914dUWYjaZLA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a245da-6914-44ee-a267-08d5886de008
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 23:06:23.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2CN6XOQ012582

There is a check just before for-loop that should ensure pipe_ctx is not null:

	/* Only supports single display */
	if (context->stream_count != 1)
		return false;

To remove the subject warning - we can rather add  an assert:
assert(pipe_ctx);

Thanks,
Roman

-----Original Message-----
From: Grodzovsky, Andrey 
Sent: Monday, March 12, 2018 6:23 PM
To: David Binderman <dcb314@hotmail.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; airlied@linux.ie; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: Re: linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]: (warning) Possible null pointer dereference: pipe_ctx



On 03/12/2018 06:22 AM, David Binderman wrote:
> hello there,
>
> Source code is
>
>
>      for (i = 0; i < dc->res_pool->pipe_count; i++) {
>          if (res_ctx->pipe_ctx[i].stream) {
>              pipe_ctx = &res_ctx->pipe_ctx[i];
>              *pipe_idx = i;
>              break;
>          }
>      }

Indeed something like

if (!pipe_ctx)
               return false;

seems the right thing here.

Harry, Roman , your opinion ?

Andrey

>
>      /* Only supports eDP */
>      if (pipe_ctx->stream->sink->link->connector_signal != 
> SIGNAL_TYPE_EDP)
>          return false;
>
> Suggest add some code to deal with the case that the for loop doesn't 
> find what it is looking for and so pipe_ctx is NULL.
>
> Regards
>
> David Binderman
>      
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
