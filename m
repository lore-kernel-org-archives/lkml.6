Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbeDIQon (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:44:43 -0400
Received: from mail-dm3nam03on0046.outbound.protection.outlook.com ([104.47.41.46]:24096
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753106AbeDIQol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:44:41 -0400
From: Deepak Singh Rawat <drawat@vmware.com>
To: Daniel Vetter <daniel@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com"
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Thread-Topic: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Thread-Index: AQHTzG/LKmgpUVY09ESOpEZ7duU7PKPxyHKAgAEAxkCABVi5gIAAiRQg
Date: Mon, 9 Apr 2018 16:44:38 +0000
Message-ID: <SN6PR05MB39509833C3635F1F52CFABE6BABF0@SN6PR05MB3950.namprd05.prod.outlook.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
 <20180405073525.GP3881@phenom.ffwll.local>
 <MWHPR05MB3117649FFA7D68D00E99AA89BABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
 <20180409083317.GM31310@phenom.ffwll.local>
In-Reply-To: <20180409083317.GM31310@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR05MB4095;7:Bx0uvh80NC5Dh0tm8LTKfT3lR7CxWO90La0gx/WW/djgY77tta49udEu9aYKQ6VBg+JHQvdzevfbS/QgTiS+9wvc9C2kz9QxqfNSjfLNpQb//wHYiEfasQU16mHgr7pDp2lrvtIPAg+aZ180vapiWMNMiQoFJhIdzRV0hDr/E1G31dGUyS7y3Ost5Px3ARYuR1aq2gpNVXDx9sAGG/KddS26z5AUGyuerq+wRVD5YlGfC3gdD61bOf6dT1k6wl2a;20:nUUIpQQq3ngP8y/NKnC1MMyy2+eb6GCtkXwzQstLC4BaCdp2UT4XbTWHkl05Qznmhhs8JvvLuEPUA/QhbZZd85xvnfENa/B/ErKYFyFTWjZmoXUwzzNH5wtkddbodr17/rhP0QTV+yHaUX33ZmfoYXJaTk86wd6wS+la3V7ndok=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 8b4ef120-d2a5-401c-5b97-08d59e392f7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4095;
x-ms-traffictypediagnostic: SN6PR05MB4095:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <SN6PR05MB4095DDB69E0A1893D3185751BABF0@SN6PR05MB4095.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR05MB4095;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(5250100002)(6116002)(305945005)(54906003)(6916009)(229853002)(7736002)(106356001)(74316002)(26005)(446003)(97736004)(486006)(39060400002)(76176011)(5890100001)(102836004)(476003)(11346002)(186003)(66066001)(478600001)(4326008)(6246003)(7416002)(5660300001)(55016002)(33656002)(81166006)(25786009)(81156014)(9686003)(68736007)(14454004)(2906002)(3660700001)(8936002)(6506007)(316002)(3280700002)(2900100001)(3846002)(59450400001)(93886005)(7696005)(8676002)(6436002)(53936002)(99286004)(105586002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4095;H:SN6PR05MB3950.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UZgjrsRrbO4H0v7oGQxPg2QtXrNUM58+9gvGiE26FxhDldTd2y27U1GDSkS8Opv+mB9wFH/9TFGi80GlDSwZaJJ9cm8uIWuX2WYsDfzQy8DinI0q+5IXr4cJLp3LU+i/On7XVrSrzut+WlpZ7awHgPa+5aVBn2Jllct/z3k7hItvbpqnCfWA6QNDfil98XZ+9+0aggwbdXKZC3l65Mc2nSk5pext/WA6aZXR6M0vj7JtbXCkPOL2bv15/t4bH8feKUB5lNE+80iB6HQd4X19oPo6kILALGUsMoJKo/8nwjGBd4yAfOux887hq32LCB1bw97+5NsNXz7ybSAmBRsO/F+DXT1xx9Lxk77aIBnTqCEEdXAtvgMqekSk5r/9uo5gF4Pr6KntU3+JN1G5t+BqQ/IErqkmOjY5sJqAwvwLMs8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4ef120-d2a5-401c-5b97-08d59e392f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:44:38.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w39GinRn018865

> > > > +void drm_plane_enable_damage_clips(struct drm_plane *plane)
> > > > +{
> > > > +	struct drm_device *dev = plane->dev;
> > > > +	struct drm_mode_config *config = &dev->mode_config;
> > > > +
> > > > +	drm_object_attach_property(&plane->base, config-
> > > >prop_damage_clips, 0);
> > > > +}
> > > > diff --git a/include/drm/drm_mode_config.h
> > > b/include/drm/drm_mode_config.h
> > > > index 7569f22..d8767da 100644
> > > > --- a/include/drm/drm_mode_config.h
> > > > +++ b/include/drm/drm_mode_config.h
> > > > @@ -628,6 +628,21 @@ struct drm_mode_config {
> > > >  	 */
> > > >  	struct drm_property *prop_crtc_id;
> > > >  	/**
> > > > +	 * @prop_damage_clips: Optional plane property to mark damaged
> > > regions
> > > > +	 * on the plane in framebuffer coordinates of the framebuffer
> > > attached
> > > > +	 * to the plane.
> > >
> > > Why should we make this optional? Looks like just another thing drivers
> > > might screw up, since we have multiple callbacks and things to set up for
> > > proper dirty tracking.
> >
> > Thanks Daniel for the review.
> >
> > I think not all compositor will be interested in sending damage, that was the
> > reason to make this optional. Also when damage is not set that means
> > user-space need full update just like eglSwapBuffersWithDamageKHR.
> >
> > I will add better documentation.
> 
> I think if we also handle this case in the helper that'd be even better:
> In the case of no damage, the helper/core code could automatically supply
> a damage rect for the entire buffer. That way drivers don't have to handle
> this case specially.
> -Daniel

Agreed.

> --
