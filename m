Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeDLCWD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 22:22:03 -0400
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:46432
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751858AbeDLCWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 22:22:00 -0400
From: Peng Fan <peng.fan@nxp.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: RE: [Xen-devel] [PATCH v6 0/1] drm/xen-front: Add support for Xen PV
 display frontend
Thread-Topic: [Xen-devel] [PATCH v6 0/1] drm/xen-front: Add support for Xen PV
 display frontend
Thread-Index: AQHTyyXsJNtdNx74IkCT0WgM10wBe6P8cunQ
Date: Thu, 12 Apr 2018 02:21:55 +0000
Message-ID: <HE1PR04MB3004EBA060BB4ADB912B186888BC0@HE1PR04MB3004.eurprd04.prod.outlook.com>
References: <20180403082833.26249-1-andr2000@gmail.com>
In-Reply-To: <20180403082833.26249-1-andr2000@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com;
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1355;7:zCpGOCq/z6bxR32FDeOuyrgQr05nEfNXwjFlQ/8pb0+vxD+9KLSlhowRUsTK6GSHLIH/sMH3WU6uZa05qenBXGB4fM5j4Kz9/HcuYlhwzHSgURck6FxGhyzL8aMqWMMR9xIHU625uv9bVUSHKiV9hVQ8sJX2uUD3GzbJ5AAJn4QIwSmaz1LDj3UTv4ddXEMu67pPt+IOk1InaxwsJRbtrkv1WeuJC1yK0PFGr9CVpXgKjoAy5pktO5x/1aabAw2F
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1355;
x-ms-traffictypediagnostic: HE1PR04MB1355:
x-microsoft-antispam-prvs: <HE1PR04MB135579ED111BC44CB47D19BC88BC0@HE1PR04MB1355.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(185117386973197)(15185016700835)(58134797142442)(4114951738403)(45079756050767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB1355;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1355;
x-forefront-prvs: 06400060E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39380400002)(39860400002)(366004)(199004)(189003)(33656002)(68736007)(81156014)(26005)(99286004)(2900100001)(5250100002)(110136005)(97736004)(2501003)(5660300001)(59450400001)(6506007)(7696005)(966005)(102836004)(8676002)(76176011)(66066001)(186003)(316002)(81166006)(6436002)(7416002)(44832011)(2201001)(105586002)(575784001)(86362001)(14454004)(6306002)(8936002)(39060400002)(3846002)(6116002)(55016002)(9686003)(3660700001)(11346002)(446003)(476003)(53946003)(25786009)(53936002)(45080400002)(478600001)(4326008)(486006)(74316002)(106356001)(305945005)(2906002)(6246003)(3280700002)(7736002)(229853002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1355;H:HE1PR04MB3004.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8C58yRAk5qRZXSkug5cH7gJZaWPVwUCi+YLupcUrqyGjjQbZ6SZv8XB3bx0B+WiNw/IjFr88aGolSx+gK0HoBeIS/+0AG2JQTq1L7So1JU33h2DlvnrMjw/iz8hyRwJ/cqQEiOMHk0Ckxmqd7BvPmJN3oDmXxtdOm/CFyIwmE1rXsjLul8lMDUm8cp4qU8QC5mb0/6c8LK0avCWVn7npNteaEU2odO4p3yjo+mbNaGmU+IrB2BueOJ2Oy6IXVcDdFrnBKW8WPEl9SozRU74BU4uhF713PSxQJ7PZ9jPxr+PWv+6nieX54v4QbTptZdfGXiX1ApWCW29E+fsBptbRbFXTr343h3LugiKO5GfxCvIk+Oq/nc0AJNROaoOjeJbiANbrf9mc/2hETmDbEqLWYyH1mquZbF2TBuVl0kT/xh0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e4649394-4ff6-4c75-2fa2-08d5a01c297c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4649394-4ff6-4c75-2fa2-08d5a01c297c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2018 02:21:55.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1355
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3C2M9IX012496

Hi Oleksandr,

Just have a question, is this drm/xen-front stuff orthogonal to xen shared
coprocessor framework for gpu, or are they exclusive?

Thanks,
Peng.
> Subject: [Xen-devel] [PATCH v6 0/1] drm/xen-front: Add support for Xen PV
> display frontend
> 
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Hello!
> 
> Boris/Daniel, I put your R-b tags, so please do let me know if this is not
> acceptable, so I remove the tags.
> 
> This patch series adds support for Xen [1] para-virtualized frontend display driver.
> It implements the protocol from include/xen/interface/io/displif.h [2].
> Accompanying backend [3] is implemented as a user-space application and its
> helper library [4], capable of running as a Weston client or DRM master.
> Configuration of both backend and frontend is done via Xen guest domain
> configuration options [5].
> 
> ****************************************************************
> ***************
> * Driver limitations
> ****************************************************************
> ***************
>  1. Configuration options 1.1 (contiguous display buffers) and 2 (backend
>     allocated buffers) below are not supported at the same time.
> 
>  2. Only primary plane without additional properties is supported.
> 
>  3. Only one video mode supported which resolution is configured via XenStore.
> 
>  4. All CRTCs operate at fixed frequency of 60Hz.
> 
> ****************************************************************
> ***************
> * Driver modes of operation in terms of display buffers used
> ****************************************************************
> ***************
>  Depending on the requirements for the para-virtualized environment, namely
> requirements dictated by the accompanying DRM/(v)GPU drivers running in
> both  host and guest environments, number of operating modes of
> para-virtualized  display driver are supported:
>   - display buffers can be allocated by either frontend driver or backend
>   - display buffers can be allocated to be contiguous in memory or not
> 
>  Note! Frontend driver itself has no dependency on contiguous memory for
>        its operation.
> 
> ****************************************************************
> ***************
> * 1. Buffers allocated by the frontend driver.
> ****************************************************************
> ***************
> 
>  The below modes of operation are configured at compile-time via  frontend
> driver's kernel configuration.
> 
>  1.1. Front driver configured to use GEM CMA helpers
>       This use-case is useful when used with accompanying DRM/vGPU driver
> in
>       guest domain which was designed to only work with contiguous buffers,
>       e.g. DRM driver based on GEM CMA helpers: such drivers can only
> import
>       contiguous PRIME buffers, thus requiring frontend driver to provide
>       such. In order to implement this mode of operation para-virtualized
>       frontend driver can be configured to use GEM CMA helpers.
> 
>  1.2. Front driver doesn't use GEM CMA
>       If accompanying drivers can cope with non-contiguous memory then, to
>       lower pressure on CMA subsystem of the kernel, driver can allocate
>       buffers from system memory.
> 
>  Note! If used with accompanying DRM/(v)GPU drivers this mode of operation
>    may require IOMMU support on the platform, so accompanying DRM/vGPU
>    hardware can still reach display buffer memory while importing PRIME
>    buffers from the frontend driver.
> 
> ****************************************************************
> ***************
> * 2. Buffers allocated by the backend
> ****************************************************************
> ***************
> 
>  This mode of operation is run-time configured via guest domain configuration
> through XenStore entries.
> 
>  For systems which do not provide IOMMU support, but having specific
> requirements for display buffers it is possible to allocate such buffers  at
> backend side and share those with the frontend.
>  For example, if host domain is 1:1 mapped and has DRM/GPU hardware
> expecting  physically contiguous memory, this allows implementing
> zero-copying  use-cases.
> 
> 
> I would like to thank at least, but not at last the following people/communities
> who helped this driver to happen ;)
> 
> 1. My team at EPAM for continuous support 2. Xen community for answering
> tons of questions on different modes of operation of the driver with respect to
> virtualized environment.
> 3. Rob Clark for "GEM allocation for para-virtualized DRM driver" [6] 4. Maarten
> Lankhorst for "Atomic driver and old remove FB behavior" [7] 5. Ville Syrjälä for
> "Questions on page flips and atomic modeset" [8]
> 
> Changes since v5:
> ****************************************************************
> ***************
> - fixed most of scripts/checkpatch.pl warnings
> 
> Changes since v4:
> ****************************************************************
> ***************
> - updated the driver after "drm/simple-kms-helper: Plumb plane state
>   to the enable hook" [14]
> - made display_mode_valid static
> - fixed page leak on event channel error path
> - changed title of the documentation to match the rest of the drivers
> - removed from the series the patch from Noralf Trønnes [12] as it was sent out
>   as a standalone one
> 
> Changes since v3:
> ****************************************************************
> ***************
> - no changes to Xen related code (shared buffer handling, event channels etc.),
>   but minor changes to xenbus_driver state machine due to re-worked unplug
>   implementation: additional state checks added
> - re-worked dumb creation code to fix race condition (drm_gem_handle_create)
> - use drm_dev_{enter|exit} to protect code which must not run when unplugged
> - re-work unplug code to fully support "zombie" DRM devices on backend
>   disconnect
> - implement a dedicated page flip time-out worker, remove logic from connector
>   detect callback
> - move mode_valid from drm_connector_helper_funcs to
> drm_simple_display_pipe_funcs
> - use drm_gem_object_put_unlocked instead of obsolete
> drm_gem_object_unreference_unlocked
> - minor cleanups
> 
> Changes since v2:
> ****************************************************************
> ***************
> - no changes to Xen related code (shared buffer handling, event channels etc.)
> - rework DRM driver release with hotplug (Daniel)
> - squash xen_drm_front and xen_drm_front_drv as they depend on each
>   other too heavily now
> - remove platform driver and instantiate DRM device
>   from xenbus driver directly
> - have serializing mutex per connector, not a single one,
>   so we don't introduce a bottle neck for multiple connectors
> - minor comments addressed (Daniel)
> 
> Changes since v1:
> ****************************************************************
> ***************
> - use SPDX license identifier, set license to GPLv2 OR MIT
> - changed midlayers to direct function calls, removed:
>   - front_ops
>   - gem_ops
> - renamed xenbus_driver callbacks to align with exisitng PV drivers
> - re-worked backend error handling with connector hotplug uevents
> - removed vblank handling so user-space doesn't have an impression
>   we really support that
> - directly use front's mode_set in display enable/disable
> - removed BUG_ON, error handling implemented
> - moved driver documentation into Documentation/gpu
> - other comments from Xen community addressed (Boris and Juergen)
> - squashed Xen and DRM patches for better interrconnection visibility
> - for your convenience driver is available at [11]
> 
> Thank you,
> Oleksandr Andrushchenko
> 
> [1]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwiki.xe
> n.org%2Fwiki%2FParavirtualization_(PV)%23PV_IO_Drivers&data=02%7C01%7
> Cpeng.fan%40nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d
> 3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C636583409853555702&sdata=kYlS
> H60OQxnE0JVYYfMLSDswZ48%2FsJCTCJTeIshsa%2Bo%3D&reserved=0
> [2]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.b
> ootlin.com%2Flinux%2Fv4.16-rc2%2Fsource%2Finclude%2Fxen%2Finterface%2F
> io%2Fdisplif.h&data=02%7C01%7Cpeng.fan%40nxp.com%7C491c555fd11142b0
> b81d08d5993d07bd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6
> 36583409853555702&sdata=UPRuN9ZLYaB6cWx%2B485viTv1KetOu5mr6VsAa
> nhB7ww%3D&reserved=0
> [3]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
> com%2Fxen-troops%2Fdispl_be&data=02%7C01%7Cpeng.fan%40nxp.com%7C4
> 91c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C1%7C636583409853555702&sdata=TuxkfTq5mJMD394E0dV78sUBrf
> NxUaFNCpyIB26zC0c%3D&reserved=0
> [4]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
> com%2Fxen-troops%2Flibxenbe&data=02%7C01%7Cpeng.fan%40nxp.com%7C4
> 91c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C1%7C636583409853555702&sdata=2jiqzZwcT7CXOW07YTGPZ9DDlL
> sarOKeCneUeeZ3npw%3D&reserved=0
> [5]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fxenbits
> .xen.org%2Fgitweb%2F%3Fp%3Dxen.git%3Ba%3Dblob%3Bf%3Ddocs%2Fman%
> 2Fxl.cfg.pod.5.in%3Bh%3Da699367779e2ae1212ff8f638eff0206ec1a1cc9%3Bh
> b%3Drefs%2Fheads%2Fmaster%23l1257&data=02%7C01%7Cpeng.fan%40nxp.
> com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C1%7C636583409853555702&sdata=wL00UQDV89%2B5rrV
> 8yQZ8rskE8wy37rymIaWbfjdIMIQ%3D&reserved=0
> [6]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
> edesktop.org%2Farchives%2Fdri-devel%2F2017-March%2F136038.html&data=
> 02%7C01%7Cpeng.fan%40nxp.com%7C491c555fd11142b0b81d08d5993d07bd
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63658340985355570
> 2&sdata=%2BgTfS2Zo4nwBIv590wyoxBOyQ%2F3rc9DOsYsEP7MSquU%3D&res
> erved=0
> [7]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.s
> pinics.net%2Flists%2Fdri-devel%2Fmsg164102.html&data=02%7C01%7Cpeng.fa
> n%40nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c
> 6fa92cd99c5c301635%7C0%7C1%7C636583409853555702&sdata=qDRZz7S6D
> zV0XxWtI57Hv9X08%2FTEc6XB7z82bdnkkaE%3D&reserved=0
> [8]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.s
> pinics.net%2Flists%2Fdri-devel%2Fmsg164463.html&data=02%7C01%7Cpeng.fa
> n%40nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c
> 6fa92cd99c5c301635%7C0%7C1%7C636583409853555702&sdata=tyIcJNSgrJF0
> Wx%2B0OES3qUIxJIxmkkqRzMQLwCARGao%3D&reserved=0
> [9]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.freedesktop.org%2Fseries%2F38073%2F&data=02%7C01%7Cpeng.fan%40
> nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C1%7C636583409853555702&sdata=M%2BbMg%2BM
> RimzNrhsjkTjt%2B2qv9WyGGbOkA7rFv7fsDuU%3D&reserved=0
> [10]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.freedesktop.org%2Fseries%2F38139%2F&data=02%7C01%7Cpeng.fan%40
> nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C1%7C636583409853555702&sdata=MzVUZgSRFDksI5
> gol9txf%2FkKy3SRgtQDR6oppPg%2BHDA%3D&reserved=0
> [11]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
> com%2Fandr2000%2Flinux%2Fcommits%2Fdrm_tip_pv_drm_v2&data=02%7C0
> 1%7Cpeng.fan%40nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686e
> a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636583409853555702&sdata=
> IfUfMOcEoRJuW7YrzzgMcCp34jIwwxEVxndfVM8ALBU%3D&reserved=0
> [12]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.freedesktop.org%2Fpatch%2F175779%2F&data=02%7C01%7Cpeng.fan%4
> 0nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C636583409853555702&sdata=9ketFmRDsilVTQ
> CeRwCMXJABL9l6aaIQF8tY9dFFhI0%3D&reserved=0
> [13]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.s
> pinics.net%2Flists%2Fdri-devel%2Fmsg170453.html&data=02%7C01%7Cpeng.fa
> n%40nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c
> 6fa92cd99c5c301635%7C0%7C0%7C636583409853555702&sdata=FCcWcL20k
> 4gn5hRMjpy6hjYs%2B%2FeKDNTKhcMq2N%2FBHOk%3D&reserved=0
> [14]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.freedesktop.org%2Fpatch%2F212321%2F&data=02%7C01%7Cpeng.fan%4
> 0nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C636583409853555702&sdata=WVa04Dos0bRI
> Q%2BdpDsngeXeH4tGfKozvSbyWhiCa2R4%3D&reserved=0
> 
> Oleksandr Andrushchenko (1):
>   drm/xen-front: Add support for Xen PV display frontend
> 
>  Documentation/gpu/drivers.rst               |   1 +
>  Documentation/gpu/xen-front.rst             |  43 ++
>  drivers/gpu/drm/Kconfig                     |   2 +
>  drivers/gpu/drm/Makefile                    |   1 +
>  drivers/gpu/drm/xen/Kconfig                 |  30 +
>  drivers/gpu/drm/xen/Makefile                |  16 +
>  drivers/gpu/drm/xen/xen_drm_front.c         | 882
> ++++++++++++++++++++++++++++
>  drivers/gpu/drm/xen/xen_drm_front.h         | 188 ++++++
>  drivers/gpu/drm/xen/xen_drm_front_cfg.c     |  77 +++
>  drivers/gpu/drm/xen/xen_drm_front_cfg.h     |  37 ++
>  drivers/gpu/drm/xen/xen_drm_front_conn.c    | 115 ++++
>  drivers/gpu/drm/xen/xen_drm_front_conn.h    |  27 +
>  drivers/gpu/drm/xen/xen_drm_front_evtchnl.c | 386 ++++++++++++
> drivers/gpu/drm/xen/xen_drm_front_evtchnl.h |  81 +++
>  drivers/gpu/drm/xen/xen_drm_front_gem.c     | 311 ++++++++++
>  drivers/gpu/drm/xen/xen_drm_front_gem.h     |  41 ++
>  drivers/gpu/drm/xen/xen_drm_front_gem_cma.c |  77 +++
>  drivers/gpu/drm/xen/xen_drm_front_kms.c     | 370 ++++++++++++
>  drivers/gpu/drm/xen/xen_drm_front_kms.h     |  26 +
>  drivers/gpu/drm/xen/xen_drm_front_shbuf.c   | 432 ++++++++++++++
>  drivers/gpu/drm/xen/xen_drm_front_shbuf.h   |  72 +++
>  21 files changed, 3215 insertions(+)
>  create mode 100644 Documentation/gpu/xen-front.rst  create mode 100644
> drivers/gpu/drm/xen/Kconfig  create mode 100644
> drivers/gpu/drm/xen/Makefile  create mode 100644
> drivers/gpu/drm/xen/xen_drm_front.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.h
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.h
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.h
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem_cma.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.h
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>  create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.h
> 
> --
> 2.16.2
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.xe
> nproject.org%2Fmailman%2Flistinfo%2Fxen-devel&data=02%7C01%7Cpeng.fan
> %40nxp.com%7C491c555fd11142b0b81d08d5993d07bd%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C636583409853555702&sdata=EhVL5bx3fsV9
> D2n6Rix%2Bcckcwp0atrgoHc%2B1heQ5HKc%3D&reserved=0
