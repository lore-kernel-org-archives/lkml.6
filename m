Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeEQPgu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:36:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46822 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751047AbeEQPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:36:49 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Daniel Vetter <daniel@ffwll.ch>
CC: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, "David Airlie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: checkpatch strict minor updates
Thread-Topic: [PATCH] drm/bridge: checkpatch strict minor updates
Thread-Index: AQHT7PpdXB2eaiLu80qlXbIEn2ahzKQz7i6A
Date: Thu, 17 May 2018 15:36:33 +0000
Message-ID: <5d971212-3210-432a-40d7-a0cba28aa222@st.com>
References: <20180515203736.9224-1-philippe.cornu@st.com>
 <20180516094338.GE3438@phenom.ffwll.local>
In-Reply-To: <20180516094338.GE3438@phenom.ffwll.local>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <20D8586B4CE13346B5C15CF1B469F419@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HFavDq019064

Hi,
Applied on drm-misc-next.
Note: patch subject has been renamed "drm/bridge: spelling and coding 
style minor fixes" to comply with checkpatch (my bad ;-), hope it is 
better, Many thanks,
Philippe :-)

On 05/16/2018 11:43 AM, Daniel Vetter wrote:
> On Tue, May 15, 2018 at 10:37:36PM +0200, Philippe Cornu wrote:
>> Minor fixes detected with "scripts/checkpatch.pl --strict"
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>> Detected when merging "drm: clarify adjusted_mode documentation for bridges"
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>>   include/drm/drm_bridge.h | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 9917651a7fdd..70131ab57e8f 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -97,7 +97,7 @@ struct drm_bridge_funcs {
>>   	/**
>>   	 * @mode_fixup:
>>   	 *
>> -	 * This callback is used to validate and adjust a mode. The paramater
>> +	 * This callback is used to validate and adjust a mode. The parameter
>>   	 * mode is the display mode that should be fed to the next element in
>>   	 * the display chain, either the final &drm_connector or the next
>>   	 * &drm_bridge. The parameter adjusted_mode is the input mode the bridge
>> @@ -301,15 +301,15 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>   		      struct drm_bridge *previous);
>>   
>>   bool drm_bridge_mode_fixup(struct drm_bridge *bridge,
>> -			const struct drm_display_mode *mode,
>> -			struct drm_display_mode *adjusted_mode);
>> +			   const struct drm_display_mode *mode,
>> +			   struct drm_display_mode *adjusted_mode);
>>   enum drm_mode_status drm_bridge_mode_valid(struct drm_bridge *bridge,
>>   					   const struct drm_display_mode *mode);
>>   void drm_bridge_disable(struct drm_bridge *bridge);
>>   void drm_bridge_post_disable(struct drm_bridge *bridge);
>>   void drm_bridge_mode_set(struct drm_bridge *bridge,
>> -			struct drm_display_mode *mode,
>> -			struct drm_display_mode *adjusted_mode);
>> +			 struct drm_display_mode *mode,
>> +			 struct drm_display_mode *adjusted_mode);
>>   void drm_bridge_pre_enable(struct drm_bridge *bridge);
>>   void drm_bridge_enable(struct drm_bridge *bridge);
>>   
>> -- 
>> 2.15.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
