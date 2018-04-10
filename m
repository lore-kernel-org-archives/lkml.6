Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeDJIRL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:17:11 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:51502 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752330AbeDJIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:17:09 -0400
Subject: Re: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
To: Deepak Rawat <drawat@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "thellstrom@vmware.com" <thellstrom@vmware.com>,
        "syeh@vmware.com" <syeh@vmware.com>
CC: "linux-graphics-maintainer@vmware.com"
        <linux-graphics-maintainer@vmware.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com"
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
From: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
Message-ID: <0e7c70bc-6587-41ea-263a-68018bcb7db2@displaylink.com>
Date: Tue, 10 Apr 2018 10:10:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522885748-67122-2-git-send-email-drawat@vmware.com>
Content-Language: en-US
X-Originating-IP: [85.14.102.90]
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To AM5PR0701MB2914.eurprd07.prod.outlook.com
 (2603:10a6:203:47::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcdeb224-807f-49a0-7554-08d59eba9037
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0701MB2914;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2914;3:j053N80pUzjfK853IJG1y3dIjF5sDxkbzMCEnA3f3dmxHhsGOPL2M9rdEZE7NgxtROJT8XAwQEDnKATbdzpjipPErIE2+1mUCxW+PuKUjidY7/Og+kalBMRu3Da11ZCECncQG1f3MDss0L2SgUSPKc0BE1BNcnrwxtapYuH6+xvzozcLbfO0y0tT+7uHHsdDnYGgNRi34ftSN/Nz5R1nwqRM+ElthIhwPYVciLsfelnyOI6cgd/LLjMvV/Ssqpyb;25:Xcbu+Ja0a9Zzy5is+PnJXJpnEm1BzUoyXPrMmrd0ael05dhRHUd+IDwDRlrygFuWblnILZJVNzgV3q6zZSEK1pdZDibuhDidV5r/7hZeZnsJKmK5R87PQoStjDOm02BVn5MbzZd9yeXO3L2kyz93u6vUOLQTP/rPHkZbTt34oCorrkpbR0nicicilnRU4OLFRsvZRY0iArVrnYdwYaS1/kB4k0LCo6gV1lRYV70oD/5ZYajFIqfuNynyhpXsxaYG6tDK3y4QNHoWGDKnNk3krRP5I6IAMD+W21wctRT+aF5A2zxqbP5lkXl55jne4ALA9Xztf3yppIJ4GYAuwfcU+g==;31:tQgOBNfBtiimg4VjiBnyw51bxAsbvER6BoLqbCqdnv7MEpnVeKZIEV7ckHaPHgoaA32O1jF0of55po9Lzn+5PyBch5h8Rvvu2SldocedhPVE5r8aGIZeX0lauEg/go1TZhhBag31QDWO1OHCPFo6PT5L0T87bt7Tc+jabPtJRXCJV2vltTIfnP+2F74nOOvKrh9NFqqBexBunnRnPElMCPgU9fD2CUPEAt/vq/Qrk2w=
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2914:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2914;20:N20ntwjSwY3ntlEEsVmgyz4TiS4h/mYRyBM7vcEWq16lT8Ektv4Nch2mAc/BhEXZE4uW3ThpmnP19eaHOqzVstmPw2LLcwSpLWC06PW77IBInFbxACdGp61LLKyqU7s11Ic3h2ntIjgRfG4EyC7ahXmrUdO5iQLKPydNDWKGDClCXQdJiJPwoJFKtfFWSyITFWPZddYUUoMTMEgU9gVdafiwtENnI1LkzlP297btEtEf5N5V1ja31Ed+JG+hh0ShUsXQye5qrzGqe+tJQdSZ5fBzNgqgQ2hazfMCNFxdyf2o5dPFUF/i50OA4XJsqT37WhKJvHaQ/vGoubQ9tsS5ZJCBecLhrxy5JmqmXKmOcmdP/B+4Y05LNNb0vVGLE4rMy2qTOoA3pXguBYWjjIk/WvedmXdHMtncwq0zhKVoHZ7ehigQWEtdXIM5KF0HnKzbZwHfj4612in09SQr+zw7WWjPg/ulLBtEHCn9u70xm9FdsJWiRanPiRqlmBRDhCtC;4:XD6NSmaM6l9QTpGNQwfeXx9uePbbGkpue1ipBtMT2HpivEkzhBNJMfkpOnmG2gYBzMMdplodwHIvbYCbbEaR0V6lmXvujRQh/xBgWmbAwWduYstFMY+vnV4xkoGEMSHCvj6UBvJUwVuT/gxooOix7+312jUif1Ur0Gaz3SSL+WQA4NwX9nZrz5ACSK/ERCbbwzwoV7AvA/4tJqfpYMtgQhdLLsCH/LWykS7mXO2/XbH/r1GvkoyqmRWO+I4u4uv8YdUBzOV2Cesp+0GTzCf3Ql8QvTjnr4RYxdZDJGFYXAu5aPohtTITrpJabYWHPWqQ
X-Microsoft-Antispam-PRVS: <AM5PR0701MB2914EEE92172F515C4459AF1E3BE0@AM5PR0701MB2914.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM5PR0701MB2914;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0701MB2914;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(376002)(346002)(366004)(39850400004)(396003)(189003)(199004)(6116002)(68736007)(3846002)(50466002)(81156014)(4326008)(31686004)(6246003)(8936002)(229853002)(65956001)(478600001)(956004)(117156002)(81166006)(11346002)(2906002)(58126008)(476003)(47776003)(2616005)(8676002)(59450400001)(52116002)(76176011)(386003)(25786009)(3260700006)(2870700001)(66066001)(67846002)(486006)(64126003)(53546011)(65806001)(305945005)(97736004)(7736002)(54906003)(6486002)(110136005)(31696002)(86362001)(65826007)(7416002)(2201001)(575784001)(5660300001)(6666003)(316002)(53936002)(106356001)(77096007)(186003)(105586002)(16576012)(23746002)(16526019)(36756003)(39060400002)(5890100001)(2501003)(26005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0701MB2914;H:[192.168.48.192];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0701MB2914;23:ONQV0VHsTI3r8WK8LNyegpTz9olI7/u/LwBmKKt?=
 =?us-ascii?Q?a4JdZdcHV8KDyinsvjKOmQY9Q/W5UJ+W8efb8PzNvAKIZHdn+OSjGz2Y6UeW?=
 =?us-ascii?Q?DX0lHuafvFM/Wtaq90LbpFn7TtwcT6OJpwwepPC+RFlg+L372W7XllJwaI09?=
 =?us-ascii?Q?0gmnLvpLZiLzAvYWoArXnXeNgnOS/g78doxqKvXYcxZaGejqD7nw4YcAxUEg?=
 =?us-ascii?Q?qy1O7v9q/VhSN7coJ1hmKj9JkI0gRLWZPHBMvRRvAkhB5HRt8tGwZ6wDqqqt?=
 =?us-ascii?Q?P2wMZJsuzc2Mf5g1T+L07Fizp3CiUpXrPjnwlPeYc5VJMeWIG3Pws3PBzvsw?=
 =?us-ascii?Q?lvB/NFhJLM5lgbl6PDsjf2SA6azMWjrzD1WYvbWhokDRtDb09TEx/aIlcFl8?=
 =?us-ascii?Q?hovnowrgEduNon3XIeeoH9Jl1ClAn30fipuUFr3y0BJqi6J6aswTFuzKFFFH?=
 =?us-ascii?Q?uHKH90/kigXokmJC5qttooF6DiewGAPB5gz3L2uXmfpi9stRudHZfmJH5LxD?=
 =?us-ascii?Q?XyJYf92V/s5KGcwejimkOtJ+JHkQRE5rFwILwRubuc5IqbVZtdUEoRL7SFRc?=
 =?us-ascii?Q?v6d3c+U1o4sPZyPSBwDqu/Hh1h36W5pCJ+2+eE1l8Sapz+K1E3wPSSyVYKGn?=
 =?us-ascii?Q?rOnFnrGKkQDyYIuRpcFvp0jmaz5jSNRZkGJHTrnmP1AVbE/qcHk0hVd0qedp?=
 =?us-ascii?Q?F2LRxEUyELYwHnmKJr/+KXTi6LYkm4GBaq8B8bczD1okI7vh4vAf6lgcQAbV?=
 =?us-ascii?Q?I17h6rTvWoxg2Z/VH4Ezn+HN+velyyPdGF2WPrN/5t8I2KgdNsTU1m9//h8A?=
 =?us-ascii?Q?GyQl8Ptk5AMAxDxLPR1RsRsUkI1O5M3WrR2T2qE22LvNz+fzVxOa6QHcKZcW?=
 =?us-ascii?Q?faI0qYivnoIUKqkK4TNYmb9dAzaBFdhJeHxxeGS+bhznfdKG+Gj/5Jd4JMVn?=
 =?us-ascii?Q?ISG9y5CGn5Z9rl3mjicUmwSS4mRZyhodhn8LwPO+uSgRDIn3KPRK9MBEkzka?=
 =?us-ascii?Q?z8AmLAf+716W2jQ/QigGmm8VkUHPn0PiVO+LTHBteobObvL1DGtX+wVmOfH3?=
 =?us-ascii?Q?K8bV9hA/JLN3XCDBdEqbHY5zsQ1fjD/QvLbNK72DVTMhEbb7QF7impzRaHpt?=
 =?us-ascii?Q?59UKR/L7BH6zHhU2LBQnnxPte2fVjv5VjcbmIZIDVwM1jzwa5eJNdz7U69/t?=
 =?us-ascii?Q?CXfBXiIY1VpTsOhdpi5ZMSLyp4eYQ3gt3epOYoTW8j65Ibj1N4fF5WSFCieK?=
 =?us-ascii?Q?udsxvNYW7VA0EC2sg/h2z7J3t58FPeCoR4ph31zShgmoJ+wVd0pn1KDB/mMw?=
 =?us-ascii?Q?ELcMtV5TLwky4qoEPsY2JQ/AJk6jnZV6baF/ma8c/AVZwryHAz7Sd0ZFImOw?=
 =?us-ascii?Q?xQWkbcSkKo7ZpiIWtsiuRasE69zOzQSzm8odqJLzDBioPx8XhhrRxVPPymYi?=
 =?us-ascii?Q?7Vt+Fe7JLDWKQG0zPQXZ+q2UZfGj2KAUfTbhcJV4iipr5tOsWZhljHVwfcfw?=
 =?us-ascii?Q?ozKrPuCxDpuyzp9QZLcz5baiaixDJpqWbuWRO/36uHRyIrdm2mxE81xcuvvG?=
 =?us-ascii?Q?CF1k2WhCWJT1WRXCK+ywRNomROf8amyM3CTQNV7wY0DsQAUQEjImsNbvEJzV?=
 =?us-ascii?Q?XrGyv925cotIlieGAV3FNNQXMuOIp7XO83FMlnmc9X20=3D?=
X-Microsoft-Antispam-Message-Info: mto4ypSkttUd/JxWiIWBt21AJ+eC8Cg5nUGl5NmHbEQgbLoeaFnvkNyebL+hnlfWE4xr1ExUjf8Mg7XURc2Q61z0SvPC/TF5dxsW6aDnMZ21bj1z7z4IM6Qr5dHgxgeJCdRmpV7OnLsy3zZc5vZKnufuOlXtjbXRUBVVcgosWNUV1q1z6o/AwjKUcUbpAj9a
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2914;6:4U0PPyssu6evmWIPSZx7egGCU5xdh6lQBvLKxiSXKB3cChEXCGFKAeGfu/2WyX2MxCEtKjoSVrlqEIWwP+5+owo4LrV9uoYORZ3n5mVz5GNugVWHHucZcCo4DkH5AXlB+SHe4lPDwyxtN9yUQlPE9xOIoTbaHN2WX4daiNDuYVO0NBTTMNvh0NNYXH3YqJJL5iAVZHgZIb880kzCJDcMc3Ca+Dr6VNTvquvqxUhlEV/Dl0ZSD83NENpniWeRQiqjguDSrVCCdN1JaCuvf8c14bZHw/LUebyClSAzhqlBb/em4EyLi2Cw9Iw78qJBBea3+oyrYCMs6+dClamhCAyLbncfkZikeltlcnSVM1wYxNT87iTr9aIZ8jvpWRmgB13O6iNofZrb6S2VwxAhqJSUw2xKWFT7DdN8esteq6VDxzPEPeQTZOyfv3s2tPVl5vMDQvi5H3VckFvjIbfy2znFWA==;5:lYNEzOwnLSGiG3+4Rz6B1fu4RNOBPRHFh187oydN0dJqoImHP9SogC1f8dAzGeUQ4IJUyQzT4z0NRm/79/VSnAzhgXEdlCy7cAbB3IRSKbiMEA9Y1iR4ezLT1po6p/MiUa7Ae2bnU4qCRsf5bpURKfMKgBr+ol0fuJoi08PInWU=;24:5fU9baeZrrtP7eJKASp+P4yQ8Zrhq0aDEUHYVlKbOLycNGcrvKQu5f92p23QeCKgPjJUDk9KcSZU0mgK4B6q9QkuaW1pXNZsWPy21rBrbqs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2914;7:3tV/wArMaFMx+GsaoeiMasE38Ku2tFpK4rtLD2ybHjOL00WasLxgXM3GpwiVaTBXE6JAjdV73ptOIOvpizbVllmEMg4OFepWdGrU5j5B/NaXjKz/4wYJn57exwgLdPOC5Exxj3O07OaCm0gxo0IXWYER3kFUCflUm6gpiOIYvA0Mug/PTLIbW3LVp7pXwMLxY5eYAhQF2GSc37mcedGAdXyM9w4UqUk5QHBK96SHHLDjpC8wqtupziyoUfIcmDCr;20:WVXbxdWKmA02AMCBK24y1nt5BjtR4/BNGH6EKPnKhNsQcP52c87G4oXF/BB6YeT+5ReobGMZcIWx1p7cKR+EnZiJNjmTLFT4hZsZmZPFjBjZo8DI7uomt3NUWiKqjddZ5vyJG0x0mX9+YEopTfXZ1vQe04s43OySLRbMISFTIv4=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 08:10:45.1802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdeb224-807f-49a0-7554-08d59eba9037
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2914
X-MC-Unique: Btv7ezxzN06NdcplPlmPjA-1
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3A8HIAL005085



On 05/04/2018 01:49, Deepak Rawat wrote:
> From: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
>
> Optional plane property to mark damaged regions on the plane in
> framebuffer coordinates of the framebuffer attached to the plane.
>
> The layout of blob data is simply an array of drm_mode_rect with maximum
> array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike plane src
> coordinates, damage clips are not in 16.16 fixed point.
>
> Damage clips are a hint to kernel as which area of framebuffer has
> changed since last page-flip. This should be helpful for some drivers
> especially for virtual devices where each framebuffer change needs to
> be transmitted over network, usb, etc.
>
> Driver which are interested in enabling DAMAGE_CLIPS property for a
> plane should enable this property using drm_plane_enable_damage_clips.
>
> Signed-off-by: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> Signed-off-by: Deepak Rawat <drawat@vmware.com>
> ---
>   drivers/gpu/drm/drm_atomic.c        | 42 +++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_atomic_helper.c |  4 ++++
>   drivers/gpu/drm/drm_mode_config.c   |  5 +++++
>   drivers/gpu/drm/drm_plane.c         | 12 +++++++++++
>   include/drm/drm_mode_config.h       | 15 +++++++++++++
>   include/drm/drm_plane.h             | 16 ++++++++++++++
>   include/uapi/drm/drm_mode.h         | 15 +++++++++++++
>   7 files changed, 109 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7d25c42..9226d24 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -669,6 +669,40 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
>   }
>   
>   /**
> + * drm_atomic_set_damage_for_plane - sets the damage clips property to plane
> + * @state: plane state
> + * @blob: damage clips in framebuffer coordinates
> + *
> + * Returns:
> + *
> + * Zero on success, error code on failure.
> + */
> +static int drm_atomic_set_damage_for_plane(struct drm_plane_state *state,
> +					   struct drm_property_blob *blob)
> +{
> +	if (blob == state->damage_clips)
> +		return 0;
> +
> +	drm_property_blob_put(state->damage_clips);
> +	state->damage_clips = NULL;
> +
> +	if (blob) {
> +		uint32_t count = blob->length/sizeof(struct drm_rect);
> +
> +		if (count > DRM_MODE_FB_DIRTY_MAX_CLIPS)
> +			return -EINVAL;
> +
> +		state->damage_clips = drm_property_blob_get(blob);
> +		state->num_clips = count;
> +	} else {
> +		state->damage_clips = NULL;
> +		state->num_clips = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
>    * drm_atomic_get_plane_state - get plane state
>    * @state: global atomic state object
>    * @plane: plane to get state object for
> @@ -793,6 +827,12 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>   		state->color_encoding = val;
>   	} else if (property == plane->color_range_property) {
>   		state->color_range = val;
> +	} else if (property == config->prop_damage_clips) {
> +		struct drm_property_blob *blob =
> +			drm_property_lookup_blob(dev, val);
> +		int ret = drm_atomic_set_damage_for_plane(state, blob);
> +		drm_property_blob_put(blob);
> +		return ret;
>   	} else if (plane->funcs->atomic_set_property) {
>   		return plane->funcs->atomic_set_property(plane, state,
>   				property, val);
> @@ -856,6 +896,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>   		*val = state->color_encoding;
>   	} else if (property == plane->color_range_property) {
>   		*val = state->color_range;
> +	} else if (property == config->prop_damage_clips) {
> +		*val = (state->damage_clips) ? state->damage_clips->base.id : 0;
>   	} else if (plane->funcs->atomic_get_property) {
>   		return plane->funcs->atomic_get_property(plane, state, property, val);
>   	} else {
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index c356545..55b44e3 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3506,6 +3506,8 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>   
>   	state->fence = NULL;
>   	state->commit = NULL;
> +	state->damage_clips = NULL;
> +	state->num_clips = 0;
>   }
>   EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
>   
> @@ -3550,6 +3552,8 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
>   
>   	if (state->commit)
>   		drm_crtc_commit_put(state->commit);
> +
> +	drm_property_blob_put(state->damage_clips);
>   }
>   EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
>   
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index e5c6533..e93b127 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -293,6 +293,11 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
>   		return -ENOMEM;
>   	dev->mode_config.prop_crtc_id = prop;
>   
> +	prop = drm_property_create(dev, DRM_MODE_PROP_BLOB, "DAMAGE_CLIPS", 0);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_damage_clips = prop;
> +
>   	prop = drm_property_create_bool(dev, DRM_MODE_PROP_ATOMIC,
>   			"ACTIVE");
>   	if (!prop)
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 6d2a6e4..071221b 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -1101,3 +1101,15 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
>   
>   	return ret;
>   }
> +
> +/**
> + * drm_plane_enable_damage_clips - enable damage clips property
> + * @plane: plane on which this property to enable.
> + */
> +void drm_plane_enable_damage_clips(struct drm_plane *plane)
> +{
> +	struct drm_device *dev = plane->dev;
> +	struct drm_mode_config *config = &dev->mode_config;
> +
> +	drm_object_attach_property(&plane->base, config->prop_damage_clips, 0);
> +}
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 7569f22..d8767da 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -628,6 +628,21 @@ struct drm_mode_config {
>   	 */
>   	struct drm_property *prop_crtc_id;
>   	/**
> +	 * @prop_damage_clips: Optional plane property to mark damaged regions
> +	 * on the plane in framebuffer coordinates of the framebuffer attached
> +	 * to the plane.
> +	 *
> +	 * The layout of blob data is simply an array of drm_mode_rect with
> +	 * maximum array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike
> +	 * plane src coordinates, damage clips are not in 16.16 fixed point.
> +	 *
> +	 * Damage clips are a hint to kernel as which area of framebuffer has
> +	 * changed since last page-flip. This should be helpful
> +	 * for some drivers especially for virtual devices where each
> +	 * framebuffer change needs to be transmitted over network, usb, etc.
> +	 */
> +	struct drm_property *prop_damage_clips;
> +	/**
>   	 * @prop_active: Default atomic CRTC property to control the active
>   	 * state, which is the simplified implementation for DPMS in atomic
>   	 * drivers.
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index f7bf4a4..9f24548 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -146,6 +146,21 @@ struct drm_plane_state {
>   	 */
>   	struct drm_crtc_commit *commit;
>   
> +	/*
> +	 * @damage_clips
> +	 *
> +	 * blob property with damage as array of drm_rect in framebuffer
> +	 * coodinates.
> +	 */
> +	struct drm_property_blob *damage_clips;
> +
> +	/*
> +	 * @num_clips
> +	 *
> +	 * Number of drm_rect in @damage_clips.
> +	 */
> +	uint32_t num_clips;
> +
>   	struct drm_atomic_state *state;
>   };
>   
> @@ -611,6 +626,7 @@ int drm_plane_init(struct drm_device *dev,
>   		   const uint32_t *formats, unsigned int format_count,
>   		   bool is_primary);
>   void drm_plane_cleanup(struct drm_plane *plane);
> +void drm_plane_enable_damage_clips(struct drm_plane *plane);
>   
>   /**
>    * drm_plane_index - find the index of a registered plane
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 50bcf42..0ad0d5b 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -873,6 +873,21 @@ struct drm_mode_revoke_lease {
>   	__u32 lessee_id;
>   };
>   
> +/**
> + * struct drm_mode_rect - two dimensional rectangle drm_rect exported to
> + * user-space.
> + * @x1: horizontal starting coordinate (inclusive)
> + * @y1: vertical starting coordinate (inclusive)
> + * @x2: horizontal ending coordinate (exclusive)
> + * @y2: vertical ending coordinate (exclusive)
> + */
> +struct drm_mode_rect {
> +	__s32 x1;
> +	__s32 y1;
> +	__s32 x2;
> +	__s32 y2;
> +};
I wonder why we can't use move 'struct drm_rect'  definition from 
'include/drm/drm_rect.h'
and include 'uapi/drm/drm_mode.h' in private header 
'include/drm/drm_rect.h'.
Is there any general rule that disallows it?
> +
>   #if defined(__cplusplus)
>   }
>   #endif
